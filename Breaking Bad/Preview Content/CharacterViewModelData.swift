//
//  CharacterViewModelData.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 03/09/2020.
//

import Foundation
import SwiftUI

extension CharacterViewModel {

    static let walterLoaded = CharacterViewModel(.walterWhite, image: .walter)
    static let walterLoading = CharacterViewModel(.walterWhite, image: .loading)
    static let cousinsLoaded = CharacterViewModel(.cousins, image: .cousins)
    static let cousinsFailed = CharacterViewModel(.cousins, image: .failed)

    static let loading =  CharacterViewModel(.walterWhite)
    static let loaded = CharacterViewModel(.cousins, image: .cousins)
    static let failed = CharacterViewModel(.walterWhite, image: .failed)
}
