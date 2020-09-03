//
//  ImageLoader.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 02/09/2020.
//

import Foundation
import Combine
import SwiftUI

class ImageLoader {

    class Image: Equatable {
        static func == (lhs: ImageLoader.Image, rhs: ImageLoader.Image) -> Bool {
            lhs.type == rhs.type
        }

        enum ImageType: Equatable {
            case loading, failed, loaded(UIImage)
        }

        let type: ImageType

        init(_ type: ImageType) {
            self.type = type
        }

        init(_ image: UIImage) {
            self.type = .loaded(image)
        }

        static let failed = Image(.failed)
        static let loading = Image(.loading)
    }

    static let cache = NSCache<NSURL, Image>()
    private var cancellable: Set<AnyCancellable> = []

    func fetch(session: APISession = URLSession.shared, url: URL, completion: @escaping (Image) -> Void) {
        if let image = Self.cache.object(forKey: url as NSURL) {
            completion(image)
            return
        }

        session
            .fetchPublisher(url: url)
            .map(\.data)
            .map(UIImage.init(data:))
            .receive(on: DispatchQueue.main)
            .replaceError(with: nil)
            .sink(receiveValue: { image in
                if let image = image {
                    let loadedImage = Image(image)
                    Self.cache.setObject(loadedImage, forKey: url as NSURL)

                    withAnimation {
                        completion(loadedImage)
                    }
                } else {
                    completion(Image(.failed))
                }
            })
            .store(in: &cancellable)
    }
}
