//
//  Endpoint.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 03/09/2020.
//

import Foundation

protocol EndpointType {
    var url: URL { get }
}

enum Endpoint: EndpointType {
    case characters

    var url: URL {
        switch self {
        case .characters:
            return URL(string: "https://breakingbadapi.com/api/characters")!
        }
    }
}
