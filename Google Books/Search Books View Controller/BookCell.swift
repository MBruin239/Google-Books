//
//  BookCell.swift
//  Google Books
//
//  Created by Michael  Bruin on 8/1/22.
//

import UIKit

class BookCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ISBNLabel: UILabel!
    @IBOutlet var thumbnailImage: UIImageView!
    
    var viewModel: BookDetailsViewModel!
    
    func setupCellWith(book: Book) {
        if book.volumeInfo.imageLinks != nil {
            let service = BookDetailsService()
            viewModel = BookDetailsViewModel(book: book,service: service)
            
            fetchImage()
        }
        
        if let title = book.volumeInfo.title {
            titleLabel.text = title
        }
        
        if let authors = book.volumeInfo.authors {
            if authors.count > 0 {
                var theAuthors = ""
                for i in 0..<authors.count {
                    theAuthors.append(authors[i])
                    if i != authors.count-1{
                        theAuthors.append(", ")
                    }
                }
                authorLabel.text = theAuthors
            }
        }
        
        let industryIdentifiers = book.volumeInfo.industryIdentifiers
        
        let isbn = industryIdentifiers[0].identifier
        ISBNLabel.text = isbn
    }
    
    func fetchImage(){
        
        viewModel.thumbnail.onUpdate = { [weak self] thumbnail in
            if (thumbnail != nil) {
                self?.thumbnailImage.image = thumbnail
            }
        }
        
        viewModel.fetchData()
    }

}
