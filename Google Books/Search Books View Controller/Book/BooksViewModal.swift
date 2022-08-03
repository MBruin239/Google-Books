//
//  BooksViewModal.swift
//  Google Books
//
//  Created by Michael  Bruin on 8/1/22.
//

import Foundation

class BooksViewModel {
    
    var string: String?

    let books: Variable<[Book]> = Variable([])
    var error: Variable<Error?> = Variable(nil)

    private let service: BooksServicing

    init(service: BooksServicing) {
        self.service = service
    }

    func fetchData() {
        self.error = Variable(nil)
        
        service.getBooks(for: string!) { [weak self] result in
            switch result {
            case .success(let bookResponse):
                self?.books.value = bookResponse.items
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
}
