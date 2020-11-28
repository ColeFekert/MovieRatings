//
//  MovieStore.swift
//  MovieRatings
//
//  Created by Cole Fekert on 11/3/20.
//

import Foundation
import UIKit

class MovieStore {
    // OLD WAY of initializing blank MovieStore
//    var allMovies = [[Movie]](repeating: [], count: 11)
    var allMovies: [[Movie]]!
    
    let movieArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent("movies.archive")
    }()

    var sectionIndexTitles = ["10", "9", "8", "7", "6", "5", "4", "3", "2", "1", "0"]
    
    var numberOfRatings = 11    // 0 - 10
    
    func saveChanges() -> Bool {
        print("Saving items to: \(movieArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allMovies, toFile: movieArchiveURL.path)
    }
    
    func removeMovie(_ movie: Movie) {
        if let index = allMovies[(10 - movie.rating)].index(of: movie) {
            allMovies[(10 - movie.rating)].remove(at: index)
        }
    }
    
    func moveMovie(fromIndexPath: IndexPath, toIndexPath: IndexPath) {
        if fromIndexPath.section == toIndexPath.section && fromIndexPath.row == toIndexPath.row {
            return
        }
        
        // Get reference to movie being moved so you can reinsert it
        let movedMovie = allMovies[fromIndexPath.section][fromIndexPath.row]
        
        // Change the rating
        movedMovie.rating = 10 - toIndexPath.section
        
        // Remove movie from array
        allMovies[fromIndexPath.section].remove(at: fromIndexPath.row)
        
        // Insert item in array at new location
        allMovies[toIndexPath.section].insert(movedMovie, at: toIndexPath.row)
    }
    
    func moveMovieTop(fromIndexPath: IndexPath, toIndexPath: IndexPath) {
        if fromIndexPath.section == toIndexPath.section {
            return
        }
        
        // Get reference to movie being moved so you can reinsert it
        let movedMovie = allMovies[fromIndexPath.section][fromIndexPath.row]
        
        // Remove movie from array
        allMovies[fromIndexPath.section].remove(at: fromIndexPath.row)
        
        // Insert item in array at front
        allMovies[10 - toIndexPath.section].insert(movedMovie, at: 0)
    }
    
    @discardableResult
    func createMovie() -> Movie {
        let newMovie = Movie(random: true)
        
        if newMovie.rating == 10 {
            allMovies[0].append(newMovie)
        } else if newMovie.rating >= 9 {
            allMovies[1].append(newMovie)
        } else if newMovie.rating >= 8 {
            allMovies[2].append(newMovie)
        } else if newMovie.rating >= 7 {
            allMovies[3].append(newMovie)
        } else if newMovie.rating >= 6 {
            allMovies[4].append(newMovie)
        } else if newMovie.rating >= 5 {
            allMovies[5].append(newMovie)
        } else if newMovie.rating >= 4 {
            allMovies[6].append(newMovie)
        } else if newMovie.rating >= 3 {
            allMovies[7].append(newMovie)
        } else if newMovie.rating >= 2 {
            allMovies[8].append(newMovie)
        } else if newMovie.rating >= 1 {
            allMovies[9].append(newMovie)
        } else if newMovie.rating >= 0 {
            allMovies[10].append(newMovie)
        }
        
        return newMovie
    }
    
    init() {
        print("Start init() for MovieStore...")
        
        do {
            let data = try Data(contentsOf: movieArchiveURL)
            if let archivedMovies = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [[Movie]] {
                allMovies = archivedMovies
            }
        } catch {
            // Default behavior - create a blank movieStore.
            allMovies = [[Movie]](repeating: [], count: 11)
        }
        
        
//        for _ in 0..<20 {
//            createMovie()
//        }
    }
}
