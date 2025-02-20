//
//  PopularMovie.swift
//  MovieFlix
//
//  Created by Δήμητρα Μαλλιαρου on 16/2/25.
//

import UIKit
import Foundation

struct PopularMovie: Codable {
    var adult: Bool? = false
    var backdrop_path: String? = ""
    var id: Int? = 0
    var original_language: String? = ""
    var original_title: String? = ""
    var overview: String? = ""
    var poster_path: String? = ""
    var release_date: String? = ""
    var vote_average: Float? = 0.0
    var vote_count: Int? = 0
}
