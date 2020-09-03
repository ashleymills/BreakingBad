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
}

private extension CharacterListViewModel {

    func fetchCompletion(_ result: Result<[Character], Networking.Error>) {
        switch result {
        case let .success(characters):
            self.characters = characters.map { CharacterViewModel($0) }
        case let .failure(error):
            self.error = error
        }
    }
}
