//
//  Book.swift
//  Google Books
//
//  Created by Michael  Bruin on 8/3/22.
//

import Foundation

// https://developers.google.com/books/docs/v1/reference/volumes#resource

struct Book: Equatable, Decodable, Identifiable {
    
    let id: String?
    public let volumeInfo: VolumeInfo
    
    static public func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
            && lhs.volumeInfo == rhs.volumeInfo
    }
    
    public struct VolumeInfo: Equatable, Decodable {
        
        public let title: String?
        public let subtitle: String?
        public let authors: [String]?
        public let imageLinks: ImageLinks?
        public let industryIdentifiers: [IndustryIdentifer]
        
        static public func ==(lhs: Book.VolumeInfo, rhs: Book.VolumeInfo) -> Bool {
            return lhs.title == rhs.title
                && lhs.subtitle == rhs.subtitle
                && lhs.authors == rhs.authors
                && lhs.imageLinks == rhs.imageLinks
                && lhs.industryIdentifiers == rhs.industryIdentifiers
        }
        
        public struct IndustryIdentifer: Equatable, Decodable {
            
            public let type: String
            public let identifier: String
            
            static public func ==(lhs: Book.VolumeInfo.IndustryIdentifer, rhs: Book.VolumeInfo.IndustryIdentifer) -> Bool {
                return lhs.identifier == rhs.identifier
                    && lhs.type == rhs.type
            }
            
        }
        
        public struct ImageLinks: Equatable, Decodable {
            
            public let smallThumbnail: URL?
            public let thumbnail: URL?
            public let small: URL?
            public let medium: URL?
            public let large: URL?
            public let extraLarge: URL?
            
            static public func ==(lhs: Book.VolumeInfo.ImageLinks, rhs: Book.VolumeInfo.ImageLinks) -> Bool {
                return lhs.smallThumbnail == rhs.smallThumbnail
                    && lhs.thumbnail == rhs.thumbnail
                    && lhs.small == rhs.small
                    && lhs.medium == rhs.medium
                    && lhs.large == rhs.large
                    && lhs.extraLarge == rhs.large
            }
        }

    }
}
