//
//  Character.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 02/09/2020.
//

import Foundation

struct Character: Codable {
    let charId: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let img: URL
    let status: Status
    let nickname: String
    let appearance: [Int]
    let portrayed: String
    let category: String
    let betterCallSaulAppearance: [Int]
}

enum Status: String, Codable {
    case alive = "Alive"
    case deceased = "Deceased"
    case empty = "?"
    case presumedDead = "Presumed dead"
    case unknown = "Unknown"
}
