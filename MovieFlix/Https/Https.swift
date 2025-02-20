//
//  Https.swift
//  MovieFlix
//
//  Created by Δήμητρα Μαλλιαρου on 16/2/25.
//

import Foundation
import UIKit

class Https: AnyObject {
    
   
    func fetchPopularMoviesTMDB(page:Int,completion: @escaping (PopularMovies) -> ()) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=\(page)")!

        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = [
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZGMyZTQ5NDdjOGM5MTFjYmZiZTdmZGZiMDhjMTZjMyIsIm5iZiI6MTU1Njc5NzYwOS43MzgsInN1YiI6IjVjY2FkOGE5YzNhMzY4MzZiM2Q5MTgzYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rii6yWn4yiUkigS9qeiNWIrJrr3zkzQtziJNaApaLAk"
        ]
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                if let popularMovies = try? JSONDecoder().decode(PopularMovies.self, from: data) {
                        print(popularMovies)
                        completion(popularMovies)
                    } else {
                        print("Invalid Response")
                    }
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
        }).resume()
        
    }
    
    
    func fetchDetailsMovieId2(id:Int,completion: @escaping (Movie) -> ()) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?language=en-US&append_to_response=credits")!
        
        print("url movie details \(url)")
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = [
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZGMyZTQ5NDdjOGM5MTFjYmZiZTdmZGZiMDhjMTZjMyIsIm5iZiI6MTU1Njc5NzYwOS43MzgsInN1YiI6IjVjY2FkOGE5YzNhMzY4MzZiM2Q5MTgzYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rii6yWn4yiUkigS9qeiNWIrJrr3zkzQtziJNaApaLAk"
        ]
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                if let movieDetails = try? JSONDecoder().decode(Movie.self, from: data) {
                        completion(movieDetails)
                    } else {
                        print("Invalid Response")
                    }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }).resume()
        
    }

    
    func fetchSimilarMoviesTMDB(id:Int,completion: @escaping (SimilarMovie) -> ()) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/similar?language=en-US&page=1")!

        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = [
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZGMyZTQ5NDdjOGM5MTFjYmZiZTdmZGZiMDhjMTZjMyIsIm5iZiI6MTU1Njc5NzYwOS43MzgsInN1YiI6IjVjY2FkOGE5YzNhMzY4MzZiM2Q5MTgzYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rii6yWn4yiUkigS9qeiNWIrJrr3zkzQtziJNaApaLAk"
        ]
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                if let similarMovies = try? JSONDecoder().decode(SimilarMovie.self, from: data) {
                        print(similarMovies)
                        completion(similarMovies)
                    } else {
                        print("Invalid Response")
                    }
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
        }).resume()
        
    }
    
    func fetchReviewsMoviesTMDB(id:Int,completion: @escaping (Reviews) -> ()) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/reviews?language=en-US&page=1")!

        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = [
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZGMyZTQ5NDdjOGM5MTFjYmZiZTdmZGZiMDhjMTZjMyIsIm5iZiI6MTU1Njc5NzYwOS43MzgsInN1YiI6IjVjY2FkOGE5YzNhMzY4MzZiM2Q5MTgzYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rii6yWn4yiUkigS9qeiNWIrJrr3zkzQtziJNaApaLAk"
        ]
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                if let reviewsMovies = try? JSONDecoder().decode(Reviews.self, from: data) {
                        print(reviewsMovies)
                        completion(reviewsMovies)
                    } else {
                        print("Invalid Response")
                    }
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
        }).resume()
        
    }
}
