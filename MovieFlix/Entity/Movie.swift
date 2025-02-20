//
//  MovieDetails.swift
//  MovieFlix
//
//  Created by Δήμητρα Μαλλιαρου on 17/2/25.
//

import UIKit
import Foundation


// MARK: - Welcome
struct Movie: Codable {
    var adult: Bool
    var backdrop_path: String
    //var belongs_to_collection: BelongsToCollection?
    var budget: Int
    var genres: [Genre] = []
//    var homepage: String
//    var id: Int
//    var imdb_id: String
//    var origin_country: [String]
//    var original_language: String
//    var original_title: String
    var overview: String
//    var popularity: Double
    var poster_path: String
    var production_companies: [ProductionCompany] = []
//    var production_countries: [ProductionCountry]
    var release_date: String
//    var revenue: Int
    var runtime: Int
//    var spoken_languages: [SpokenLanguage]
//    var status: String
//    var tagline: String
    var title: String
//    var video: Bool
    var vote_average: Double
//    var vote_count: Int

    var credits: Credits?
}

struct BelongsToCollection: Codable {
    var id: Int
    var name: String
    var poster_path: String
    var backdrop_path: String
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logo_path: String?
    let name: String
    let origin_country: String
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    var iso3166_1: String
    var name: String
    
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    var english_name: String
    var iso639_1: String
    var name: String

}

struct Credits: Codable {
    var cast: [Cast] = []
}

struct Cast: Codable {
    var name: String?
    var original_name: String?
    var popularity: Float?
    var profile_path: String?
    var cast_id: Int?
    var character: String?
    var credit_id: String?
}
