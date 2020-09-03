//
//  String.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 03/09/2020.
//

import Foundation

extension String {
    var forSearching: String {
        let locale = Locale.current
        let options = NSString.CompareOptions.diacriticInsensitive.union(.widthInsensitive)
        let unaccented = folding(options: options, locale: locale)
        let lowercase = unaccented.lowercased(with: locale)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        let trimmed = lowercase.components(separatedBy: nonAlphaNumeric).joined(separator: "")
        return trimmed
    }
}
