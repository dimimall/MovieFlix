//
//  Reviews.swift
//  MovieFlix
//
//  Created by Δήμητρα Μαλλιαρου on 20/2/25.
//

import Foundation

struct Reviews: Codable {
    var results: [Results] = []
}

struct Results: Codable {
    
    var author: String?
    var author_details: AuthorDetails?
    var content: String?
}

struct AuthorDetails: Codable {
    var name: String?
    var username: String?
    var avatar_path: String?
    var rating: Int?
}
