//
//  Google_BooksTests.swift
//  Google BooksTests
//
//  Created by Michael  Bruin on 8/1/22.
//

import XCTest
@testable import Google_Books

class Google_BooksTests: XCTestCase {
    var booksService: BooksService!
    var booksViewModel: BooksViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()

        booksService = BooksService()
        booksViewModel = BooksViewModel(service: booksService)
        
    }

    override func tearDownWithError() throws {
        booksService = nil
        booksViewModel = nil
        try super.tearDownWithError()
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            let bookPromise = expectation(description: "Books Completion handler invoked")

            booksViewModel.books.onUpdate = { [self] _ in
                bookPromise.fulfill()
                for book in booksViewModel.books.value {
                    if book.volumeInfo.imageLinks != nil {
                        let imagePromise = expectation(description: "Image Completion handler invoked")
                        let service = BookDetailsService()
                        let viewModel = BookDetailsViewModel(book: book,service: service)
                        viewModel.thumbnail.onUpdate = { thumbnail in
                            if (thumbnail != nil) {
                                imagePromise.fulfill()
                            }
                        }

                        viewModel.fetchData()
                        wait(for: [imagePromise], timeout: 5)

                    }
                }
            }
            booksViewModel.string = "D&D"
            
            booksViewModel.fetchData()
            wait(for: [bookPromise], timeout: 5)
        }
    }

}
