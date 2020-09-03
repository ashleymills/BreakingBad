//
//  CharacterViewModel.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 02/09/2020.
//

import Foundation
import Combine
import SwiftUI

class CharacterViewModel: ObservableObject {

    private let character: Character
    @Published var image: ImageLoader.Image
    let nameForSearching: String

    init(_ character: Character, image: ImageLoader.Image = .init(.loading)) {
        self.character = character
        self.image = image
        self.nameForSearching = character.name.forSearching
    }

    var imageUrl: URL {
        character.img
    }

    var name: String {
        character.name
    }

    var occupation: String {
        character.occupation.joined(separator: ",\n")
    }

    var status: String {
        character.status.rawValue
    }

    var nickname: String {
        character.nickname
    }

    var seasons: String {
        character.appearance.map(String.init).joined(separator: ", ")
    }

    func nameContains(_ text: String) -> Bool {
        nameForSearching.contains(text.forSearching)
    }

    func appearedInSeasons(_ seasons: [Int]) -> Bool {
        for season in seasons {
            if character.appearance.contains(season) {
                return true
            }
        }
        return false
    }
}

extension CharacterViewModel: Equatable {
    static func == (lhs: CharacterViewModel, rhs: CharacterViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

extension CharacterViewModel: Identifiable {
    var id: Int { character.charId }
}
