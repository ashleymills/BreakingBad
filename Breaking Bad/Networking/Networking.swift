//
//  Networking.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 02/09/2020.
//

import Foundation
import Combine

class Networking {

    enum Error: LocalizedError, Identifiable {
        var id: String { "\(self)" }

        case url(URLError)
        case decode(Swift.Error)

        var errorDescription: String? {
            switch self {
            case let .url(error):
                return "Network error: \(error.localizedDescription)"
            case let .decode(error):
                return "Decoding error: \(error.localizedDescription)"
            }
        }
    }


    private var cancellables: Set<AnyCancellable> = []
    private lazy var decoder = makeDecoder()

    func fetch<T>(_ endpoint: EndpointType, session: APISession = URLSession.shared, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        session
            .fetchPublisher(url: endpoint.url)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .mapError(Error.decode)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                if case let .failure(error) = $0 {
                    completion(.failure(error))
                }
            }, receiveValue: { result in
                completion(.success(result))
            })
            .store(in: &cancellables)
    }
}

private extension Networking {
    func makeDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

