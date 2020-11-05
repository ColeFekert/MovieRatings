//
//  MovieStore.swift
//  MovieRatings
//
//  Created by Cole Fekert on 11/3/20.
//

import Foundation
import UIKit

class MovieStore {
    var allMovies = [[Movie]](repeating: [], count: 11)

    var sectionIndexTitles = ["10", "9", "8", "7", "6", "5", "4", "3", "2", "1", "0"]
    
    func removeMovie(_ movie: Movie) {
        if let index = allMovies[movie.rating].index(of: movie) {
            allMovies[movie.rating].remove(at: index)
        }
    }
    
    @discardableResult
    func createMovie() -> Movie {
        let newMovie = Movie(random: true)
        
        if newMovie.rating == 10 {
            allMovies[10].append(newMovie)
        } else if newMovie.rating >= 9 {
            allMovies[9].append(newMovie)
        } else if newMovie.rating >= 8 {
            allMovies[8].append(newMovie)
        } else if newMovie.rating >= 7 {
            allMovies[7].append(newMovie)
        } else if newMovie.rating >= 6 {
            allMovies[6].append(newMovie)
        } else if newMovie.rating >= 5 {
            allMovies[5].append(newMovie)
        } else if newMovie.rating >= 4 {
            allMovies[4].append(newMovie)
        } else if newMovie.rating >= 3 {
            allMovies[3].append(newMovie)
        } else if newMovie.rating >= 2 {
            allMovies[2].append(newMovie)
        } else if newMovie.rating >= 1 {
            allMovies[1].append(newMovie)
        } else if newMovie.rating >= 0 {
            allMovies[0].append(newMovie)
        }
        
        return newMovie
    }
    
//    init() {
//        for _ in 0..<20 {
//            createMovie()
//        }
//    }
}
