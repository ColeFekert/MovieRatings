//
//  MovieStore.swift
//  MovieRatings
//
//  Created by Cole Fekert on 11/3/20.
//

import Foundation
import UIKit

class MovieStore {
    var allMovies = [Movie]()
    
    var sectionIndexTitles = ["2020s", "2010s", "2000s", "1990s", "1980s", "1970s", "1960s", "1950s", "1940s", "1930s", "1920s"]
    
    @discardableResult
    func createMovie() -> Movie {
        let newMovie = Movie(random: true)
        allMovies.append(newMovie)
        
        return newMovie
    }
    
    init() {
        for _ in 0..<6 {
            createMovie()
        }
    }
}
