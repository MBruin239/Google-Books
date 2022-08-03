//
//  BooksService.swift
//  Google Books
//
//  Created by Michael  Bruin on 8/1/22.
//

import Foundation
import UIKit

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

struct BookResponse: Decodable {
    let kind: String
    let items: [Book]
    let totalItems: Int?
}

protocol BooksServicing {
    func getBooks(for string: String, _ completion: @escaping (Result<BookResponse, Error>) -> Void)
}

class BooksService: BooksServicing {
    func getBooks(for string: String, _ completion: @escaping (Result<BookResponse, Error>) -> Void) {
        
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(string)")!

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
#if DEBUG
            let dict = try? data!.to(type: [String: Any].self)
            print(dict as Any)
#endif
            let decoded = try! jsonDecoder.decode(BookResponse.self, from: data!)
                
            completion(.success(decoded))
        }.resume()
    }
}
