//
//  ViewControllerProvider.swift
//  Google Books
//
//  Created by Michael  Bruin on 8/1/22.
//

import Foundation
import UIKit

enum ViewControllerProvider {
    static var searchViewController: SearchViewController {
        let service = BooksService()
        let viewModel = BooksViewModel(service: service)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        viewController.viewModel = viewModel
        return viewController
    }

    static func savedBooksViewController(for booksManager: SavedBooksManager) -> SavedBooksViewController {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SavedBooksViewController") as! SavedBooksViewController
        viewController.savedBooksManager = booksManager
        return viewController
    }
}
