//
//  SimilarMoview.swift
//  MovieFlix
//
//  Created by Δήμητρα Μαλλιαρου on 20/2/25.
//

import Foundation

struct SimilarMovie: Codable {
    
    var results: [ResultsSimilar] = []
}

struct ResultsSimilar: Codable {
    
    var title: String?
    var backdrop_path: String?
    var vote_average: Float?
}
