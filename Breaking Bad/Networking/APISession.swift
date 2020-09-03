//
//  APISession.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 03/09/2020.
//

import Foundation
import Combine

protocol APISession {
    func fetchPublisher(url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

extension URLSession: APISession {
    func fetchPublisher(url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        dataTaskPublisher(for: url)
            .eraseToAnyPublisher()
    }
}

class MockSession: APISession {
    internal init(data: [URL: Data]) {
        self.data = data
    }

    let data: [URL: Data]

    func fetchPublisher(url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        let data = self.data[url] ?? Data()
        print(data)
        return Just((data: data, response: URLResponse()))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
    }
}
