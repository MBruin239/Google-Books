//
//  ViewController.swift
//  Google Books
//
//  Created by Michael  Bruin on 8/1/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?

    var viewModel: BooksViewModel!
    
    let saveBookManager = SavedBooksManager()
    
    @IBOutlet var savedBooksBtn: UIButton!

    @IBOutlet weak var tableView: UITableView! { didSet { tableView.delegate = self;         tableView.dataSource = self } }
    
    @IBOutlet weak var searchTextField: UITextField! { didSet { searchTextField.delegate = self } }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.books.onUpdate = { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func showSavedBooksAction(sender: UIButton!) {
        coordinator?.displaySaveBooks(of: saveBookManager)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.books.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        let book = viewModel.books.value[indexPath.row]
        
        cell.setupCellWith(book: book)
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = viewModel.books.value[indexPath.row]
        
        saveBookManager.addBook(book: book)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
        
    // This function is called when you click return key in the text field.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        if textField == self.searchTextField {
            if let string = textField.text {
                if string != "" {
                    viewModel.string = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    viewModel.fetchData()
                }
            }
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
