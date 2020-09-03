//
//  NetworkingTests.swift
//  Breaking Bad Tests
//
//  Created by Ashley Mills on 03/09/2020.
//

import XCTest
@testable import Breaking_Bad

class NetworkingTests: XCTestCase {

    struct Person: Codable, Equatable {
        let name: String
        let height: Int
    }

    struct Endpoint: EndpointType {
        let url = URL(string: "test")!
    }

    func testFetchSuccess() {
        let person = Person(name: "Ash", height: 185)
        let data = try! JSONEncoder().encode(person)

        let session = MockSession(data: [Endpoint().url: data])
        let networking = Networking()

        let expect = XCTestExpectation(description: "testFetchSuccess")

        networking.fetch(Endpoint(), session: session) { (result: Result<Person, Networking.Error>) in
            switch result {
            case let .success(p):
                XCTAssertEqual(p, person)
            case let .failure(error):
                XCTAssertNil(error)
            }
            expect.fulfill()
        }

        wait(for: [expect], timeout: 5)
    }

    func testFetchFail() {
        let data = Data()

        let session = MockSession(data: [Endpoint().url: data])
        let networking = Networking()

        let expect = XCTestExpectation(description: "testFetchFail")

        networking.fetch(Endpoint(), session: session) { (result: Result<Person, Networking.Error>) in
            switch result {
            case .success:
                XCTFail("This test shouldn't return a person")
            case let .failure(error):
                XCTAssertNotNil(error)
            }
            expect.fulfill()
        }

        wait(for: [expect], timeout: 5)
    }
}
