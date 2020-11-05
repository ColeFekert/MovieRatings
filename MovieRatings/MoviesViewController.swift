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

        if movieStore.allMovies[indexPath.section][indexPath.row].year == 0 {
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
            
            return cell
        }
        
        cell.textLabel?.text = movieStore.allMovies[indexPath.section][indexPath.row].title
        cell.detailTextLabel?.text = "\(movieStore.allMovies[indexPath.section][indexPath.row].year)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let movie = movieStore.allMovies[indexPath.section][indexPath.row]
            
            // Remove the movie from the store
            movieStore.removeMovie(movie)
            
            // Also remove that row from the able view with an animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Section Headers
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 11
    }
    
    override func sectionIndexTitles(for: UITableView) -> [String]? {
        return movieStore.sectionIndexTitles
    }
}
