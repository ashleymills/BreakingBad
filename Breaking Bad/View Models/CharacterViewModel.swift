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

    init(_ character: Character, image: ImageLoader.Image = .init(.loading)) {
        self.character = character
        self.image = image
    }

    @Published var image: ImageLoader.Image

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
}

extension CharacterViewModel: Equatable {
    static func == (lhs: CharacterViewModel, rhs: CharacterViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

extension CharacterViewModel: Identifiable {
    var id: Int { character.charId }
}
