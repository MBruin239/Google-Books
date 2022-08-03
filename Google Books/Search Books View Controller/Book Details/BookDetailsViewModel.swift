//
//  BookViewModal.swift
//  Google Books
//
//  Created by Michael  Bruin on 8/1/22.
//

import Foundation
import UIKit

class BookDetailsViewModel {
    
    let book: Book

    let thumbnail: Variable<UIImage?> = Variable(nil)
    let error: Variable<Error?> = Variable(nil)

    private let service: BookDetailsServicing

    init(book: Book, service: BookDetailsServicing) {
        self.book = book
        self.service = service
    }

    func fetchData() {
        service.getThumbnail(for: book) { [weak self] result in
            switch result {
            case .success(let image):
                self?.thumbnail.value = image
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
}
