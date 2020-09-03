//
//  CharactersViewModel.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 02/09/2020.
//

import Foundation
import Combine
import SwiftUI

class CharacterListViewModel: ObservableObject {

    private let session: APISession
    private let imageLoader = ImageLoader()
    private let networking = Networking()
    private var hasFetchedCharacters = false

    @Published var characters: [CharacterViewModel] = []
    @Published var error: Networking.Error?
    @Published var filter: String = ""
    @Published var selectedSeasons: [Int: Bool] = [:]
    @Published var showingCharacter: CharacterViewModel?

    var filteredCharacters: [CharacterViewModel] {

        let seasons = Array(selectedSeasons.filter(\.value).keys)
        let charactersBySeason = characters.filter { $0.appearedInSeasons(seasons) }

        guard !filter.isEmpty else { return charactersBySeason }

        return charactersBySeason.filter { character in
            return character.nameContains(filter)
        }
    }

    init(session: APISession = URLSession.shared) {
        self.session = session
    }

    func fetch() {
        guard !hasFetchedCharacters else { return }
        networking.fetch(Endpoint.characters, session: session, completion: fetchCompletion)
        hasFetchedCharacters = true
    }

    func loadImage(for character: CharacterViewModel) {
        guard [.failed, .loading].contains(character.image) else { return }
        imageLoader.fetch(session: session, url: character.imageUrl) { [self] image in
            characters.firstIndex(of: character).map { characters[$0].image = image }
        }
    }

    subscript(_ season: Int) -> Bool {
        get {
            selectedSeasons[season, default: false]
        }
        set {
            selectedSeasons[season] = newValue
        }
    }

    var seasons: [Int] {
        Array(selectedSeasons.keys).sorted()
    }
}

private extension CharacterListViewModel {

    func fetchCompletion(_ result: Result<[Character], Networking.Error>) {
        switch result {
        case let .success(characters):
            self.characters = characters.map { CharacterViewModel($0) }

            if let maxSeason = characters.flatMap(\.appearance).max() {
                selectedSeasons = (1...maxSeason).reduce(into: [:]) { $0[$1] = true }
            }

        case let .failure(error):
            self.error = error
        }
    }
}
