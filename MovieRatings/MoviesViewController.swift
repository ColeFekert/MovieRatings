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
    
    // Editing and Adding Buttons
    @IBAction func addNewItem(_ sender: UIButton) {
        // Create a new movie and add it to the store
        let newMovie = movieStore.createMovie()
        
        // Figure out where that new item is in the array
        if let index = movieStore.allMovies[newMovie.rating].index(of: newMovie) {
            let indexPath = IndexPath(row: index, section: newMovie.rating)
            
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        // When currently editing...
        if isEditing {
            // Change the text of the button to inform user of the state
            sender.setTitle("Edit", for: .normal)
            
            // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // Change the text of button to inform user of the state
            sender.setTitle("Done", for: .normal)
            
            // Turn on editing mode
            setEditing(true, animated: true)
        }
    }
    
    // tableView Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieStore.allMovies[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(10 - section) + "/10"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // created an instance of UITableViewCell, with default appearance
        // let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        // get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        // set the text on the cell with the description of the item that is at the nth index of movies, where n = row this cell will appear in on the tableView
//        let movie = movieStore.allMovies[indexPath.row]
        
        // TODO: Figure out how to break out of the for loop for each movie in a section - whats happening is that we are looping through every movie and checking if each movie is in the decade, if it is then set the cell's attributes to those of that movie. However, if another movie comes along with the same decade - it'll overwrite that previous movie.
        
//        for movie in movieStore.allMovies[indexPath.section] {
//                cell.textLabel?.text = movie.title
//                cell.detailTextLabel?.text = "\(movie.year)"
//        }
        
        if movieStore.allMovies[indexPath.section][indexPath.row].year == 0 {
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
            
            return cell
        }
        
        cell.textLabel?.text = movieStore.allMovies[indexPath.section][indexPath.row].title
        cell.detailTextLabel?.text = "\(movieStore.allMovies[indexPath.section][indexPath.row].year)"
        
        
//        for movie in movieStore.allMovies {
////            print(movie.title) DEBUGGING
//            if (movie.year - (2020 - indexPath.section * 10) <= 9 && movie.year - (2020 - indexPath.section * 10) >= 0) {
//                cell.textLabel?.text = movie.title
//                cell.detailTextLabel?.text = "\(movie.year)"
//
////                return cell       DOESNT WORK
////                break             DOESNT WORK
//            }
//        }
        
        
        
        return cell
    }
    
    // Section Headers
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 11
    }
    
    override func sectionIndexTitles(for: UITableView) -> [String]? {
        return movieStore.sectionIndexTitles
    }
}
