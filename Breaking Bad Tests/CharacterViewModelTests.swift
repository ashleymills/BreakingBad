//
//  CharacterViewModelTests.swift
//  Breaking Bad Tests
//
//  Created by Ashley Mills on 03/09/2020.
//

import XCTest
@testable import Breaking_Bad

class CharacterViewModelTests: XCTestCase {

    func testInit() throws {
        let walterWhite = Character(charId: 1, name: "Walter White", birthday: "09-07-1958", occupation: ["High School Chemistry Teacher","Meth King Pin"], img: URL(string: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")!, status: .presumedDead, nickname: "Heisenberg", appearance: [1,2,3,4,5], portrayed: "Bryan Cranston", category: "Breaking Bad", betterCallSaulAppearance: [])

        let viewModel = CharacterViewModel(walterWhite)

        XCTAssertEqual(viewModel.name, "Walter White")
        XCTAssertEqual(viewModel.imageUrl.absoluteString, "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")
        XCTAssertEqual(viewModel.occupation, "High School Chemistry Teacher,\nMeth King Pin")
        XCTAssertEqual(viewModel.status, "Presumed dead")
        XCTAssertEqual(viewModel.nickname, "Heisenberg")
        XCTAssertEqual(viewModel.image, ImageLoader.Image.loading)
        XCTAssertEqual(viewModel.seasons, "1, 2, 3, 4, 5")
        XCTAssertTrue(viewModel.nameContains("alt"))
        XCTAssertFalse(viewModel.nameContains("xyz"))
        XCTAssertTrue(viewModel.didAppearInSeasons([1, 3]))
        XCTAssertTrue(viewModel.didAppearInSeasons([5, 6]))
        XCTAssertFalse(viewModel.didAppearInSeasons([6]))
    }
}
