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
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        // Create a new movie and add it to the store
        let newMovie = movieStore.createMovie()
        
        // Figure out where that new item is in the array
        if let index = movieStore.allMovies[(10 - newMovie.rating)].index(of: newMovie) {
            let indexPath = IndexPath(row: index, section: (10 - newMovie.rating))
            
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        // set the text on the cell with the description of the item that is at the nth index of movies, where n = row this cell will appear in on the tableView

        let movie = movieStore.allMovies[indexPath.section][indexPath.row]
        
        if movie.ratingChanged {
            var targetIndexPath: IndexPath = indexPath
            targetIndexPath.section = movie.rating
            
            movieStore.moveMovieTop(fromIndexPath: indexPath, toIndexPath: targetIndexPath)
            
            movie.finishedChangingRating()
            
            tableView.reloadData()
        }
        
        if movie.year == 0 {
            cell.titleLabel.text = ""
            cell.yearLabel.text = ""
            cell.dateLabel.text = "01/01/1970"
            
            return cell
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: (movie.dateCreated))
        
        
        cell.titleLabel.text = movie.title
        cell.yearLabel.text = "\(movie.year)"
        if (movie.year < 1930) {
            cell.yearLabel.textColor = UIColor(red: 168/255, green: 122/255, blue: 52/255, alpha: 1.0)
        } else if (movie.year < 1940) {
            cell.yearLabel.textColor = UIColor(red: 210/255, green: 126/255, blue: 0/255, alpha: 1.0)
        } else if (movie.year < 1950) {
            cell.yearLabel.textColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1.0)
        } else if (movie.year < 1960) {
            cell.yearLabel.textColor = UIColor(red: 192/255, green: 178/255, blue: 63/255, alpha: 1.0)
        } else if (movie.year < 1970) {
            cell.yearLabel.textColor = UIColor(red: 128/255, green: 204/255, blue: 127/255, alpha: 1.0)
        } else if (movie.year < 1980) {
            cell.yearLabel.textColor = UIColor(red: 64/255, green: 229/255, blue: 191/255, alpha: 1.0)
        } else if (movie.year < 1990) {
            cell.yearLabel.textColor = UIColor(red: 0/255, green: 255/255, blue: 255/255, alpha: 1.0)
        } else if (movie.year < 2000) {
            cell.yearLabel.textColor = UIColor(red: 63/255, green: 192/255, blue: 255/255, alpha: 1.0)
        } else if (movie.year < 2010) {
            cell.yearLabel.textColor = UIColor(red: 127/255, green: 128/255, blue: 255/255, alpha: 1.0)
        } else if (movie.year < 2020) {
            cell.yearLabel.textColor = UIColor(red: 191/255, green: 64/255, blue: 255/255, alpha: 1.0)
        } else if (movie.year < 2030) {
            cell.yearLabel.textColor = UIColor(red: 255/255, green: 0/255, blue: 255/255, alpha: 1.0)
        }
        
        
        cell.dateLabel.text = "\(dateString)"
        
        let now = Date()
        
        let timeSpanFromDate = DateFormatter()
        timeSpanFromDate.dateFormat = "D"
        
        let currentDayOfYear = timeSpanFromDate.string(from: now)
        let movieDayOfYear = timeSpanFromDate.string(from: movie.dateCreated)
        
        timeSpanFromDate.dateFormat = "YYYY"
        
        let currentYear = timeSpanFromDate.string(from: now)
        let movieYear = timeSpanFromDate.string(from: movie.dateCreated)
        
        let currentYearInt = Int(currentYear) ?? 2020
        let movieYearInt = Int(movieYear) ?? 1234
        let currentDayOfYearInt = Int(currentDayOfYear) ?? 100
        let movieDayOfYearInt = Int(movieDayOfYear) ?? 100
        
        if (movieYearInt == currentYearInt) {
            if (movieDayOfYearInt == currentDayOfYearInt) {
                cell.dateLabel.textColor = UIColor.systemIndigo
            } else if (currentDayOfYearInt - movieDayOfYearInt > 14) {
                cell.dateLabel.textColor = UIColor.purple
            } else if (currentYearInt - movieYearInt == 1) {
                cell.dateLabel.textColor = UIColor.blue
            } else if (currentYearInt - movieYearInt == 2) {
                cell.dateLabel.textColor = UIColor.green
            } else if (currentYearInt - movieYearInt == 3) {
                cell.dateLabel.textColor = UIColor.yellow
            } else if (currentYearInt - movieYearInt == 4) {
                cell.dateLabel.textColor = UIColor.orange
            } else if (currentYearInt - movieYearInt == 5) {
                cell.dateLabel.textColor = UIColor.red
            }
        }
        
//        cell.dateLabel.textColor = UIColor(

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let movie = movieStore.allMovies[indexPath.section][indexPath.row]
            
            
            // Build alert controller
            let title = "Delete \(movie.title)?"
            let message = "Are you sure you want to delete this movie?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "I changed my mind...", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteMessages = ["Hasta la vista, baby.", "Get off my plane!", "Consider that a divorce.", "I expect you to die.", "You killed my father, prepare to die.", "See you at the party, Richter!", "Bingo!", "A man's got to know his limitations.", "Adriaaaaaaaaaan!", "Party's Over!", "Game over man! Game over!", "That's right, Dude. 100% certain.", "Certain DEATH!"]
            
            let idx = arc4random_uniform(UInt32(deleteMessages.count))
            let randomTitle = deleteMessages[Int(idx)]
            
            let deleteAction = UIAlertAction(title: randomTitle, style: .destructive, handler: {
                (action) -> Void in
                // Remove the movie from the store
                self.movieStore.removeMovie(movie)
                
                // Also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        movieStore.moveMovie(fromIndexPath: sourceIndexPath, toIndexPath: destinationIndexPath)
    }
    
    // Section Headers
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return movieStore.numberOfRatings
    }
    
    override func sectionIndexTitles(for: UITableView) -> [String]? {
        return movieStore.sectionIndexTitles
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the height of the status bar
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the triggered segue is the showItem segue
        switch segue.identifier {
        case "showItem"?:
            // Figure out which row was just tapped
            if let section = tableView.indexPathForSelectedRow?.section {
                if let row =
                    tableView.indexPathForSelectedRow?.row {
                        // Get the item associated with this row and pass it along
                        let movie = movieStore.allMovies[section][row]
                        let detailViewController = segue.destination as! DetailViewController
                        detailViewController.movie = movie
                }
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
}
