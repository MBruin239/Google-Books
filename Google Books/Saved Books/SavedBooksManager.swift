//
//  SavedBooksManager.swift
//  Google Books
//
//  Created by Michael  Bruin on 8/1/22.
//

import Foundation

class SavedBooksManager {
    var savedBooks: [Book] = []
    
    func addBook(book: Book){
        if !checkSavedBooksForBook(book: book) {
            savedBooks.append(book)
        }
    }
    
    func removeBook(book: Book){
        for i in stride(from: savedBooks.count-1, through: 0, by: -1) {
            let sBook = savedBooks[i]
            if sBook == book{
                savedBooks.remove(at: i)
                return
            }
        }
    }
    
    func checkSavedBooksForBook(book: Book) -> Bool {
        for sBook in savedBooks {
            if book == sBook {
                return true
            }
        }
        return false
    }
}

