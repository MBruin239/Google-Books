//
//  BookDetailsServicing.swift
//  Google Books
//
//  Created by Michael  Bruin on 8/1/22.
//

import UIKit

enum ImageError: Error {
    case couldNotDecode
}

protocol BookDetailsServicing {
    func getThumbnail(for book: Book, _ completion: @escaping (Result<UIImage, Error>) -> Void)
}

class BookDetailsService: BookDetailsServicing {
    func getThumbnail(for book: Book, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: (book.volumeInfo.imageLinks?.thumbnail)!) { data, _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            guard let decoded = UIImage(data: data!) else {
                completion(.failure(ImageError.couldNotDecode))
                return
            }

            completion(.success(decoded))
        }.resume()
    }
}


