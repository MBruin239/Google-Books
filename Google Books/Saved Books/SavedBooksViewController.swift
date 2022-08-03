//
//  SavedBooksViewController.swift
//  Google Books
//
//  Created by Michael  Bruin on 8/1/22.
//

import UIKit

class SavedBooksViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    var savedBooksManager: SavedBooksManager?

    @IBOutlet weak var tableView: UITableView! { didSet { tableView.delegate = self;         tableView.dataSource = self } }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func handleRemoveBook(index: Int) {
        if let book = savedBooksManager?.savedBooks[index] {
            savedBooksManager?.removeBook(book: book)
            tableView.reloadData()
        }
    }
}

extension SavedBooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (savedBooksManager?.savedBooks.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        if let book = savedBooksManager?.savedBooks[indexPath.row] {
            cell.setupCellWith(book: book)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Remove action
        let remove = UIContextualAction(style: .destructive,
                                       title: "Remove") { [weak self] (action, view, completionHandler) in
                                        self?.handleRemoveBook(index: indexPath.row)
                                        completionHandler(true)
        }
        remove.backgroundColor = .systemRed

        let configuration = UISwipeActionsConfiguration(actions: [remove])

        return configuration
    }
}

extension SavedBooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
