//
//  MoviesViewController.swift
//  MovieRatings
//
//  Created by Cole Fekert on 11/3/20.
//  Copyright © 2020 Cole Fekert. All rights reserved.
//

import Foundation
import UIKit

class MoviesViewController: UITableViewController {
    var movieStore: MovieStore!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        for movie in movieStore.allMovies {
            if (movie.year - (2020 - section * 10) <= 9 && movie.year - (2020 - section * 10) >= 0) {
                count += 1
            }
        }
        
        return count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 11
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(2020 - section * 10) + "s"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // created an instance of UITableViewCell, with default appearance
        // let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        // get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        // set the text on the cell with the description of the item that is at the nth index of movies, where n = row this cell will appear in on the tableView
//        let movie = movieStore.allMovies[indexPath.row]
        
        // TODO: Figure out why some movies arent being printed while others are duplicated
        
        
        
        for movie in movieStore.allMovies {
//            print(movie.title) DEBUGGING
            if (movie.year - (2020 - indexPath.section * 10) <= 9 && movie.year - (2020 - indexPath.section * 10) >= 0) {
                cell.textLabel?.text = movie.title
                cell.detailTextLabel?.text = "\(movie.year)"
            }
        }
        
        
            
        
        
        
        return cell
    }
    
    override func sectionIndexTitles(for: UITableView) -> [String]? {
        return movieStore.sectionIndexTitles
    }
}
