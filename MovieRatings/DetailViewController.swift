//
//  DetailViewController.swift
//  MovieRatings
//
//  Created by Cole Fekert on 11/8/20.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var titleField: UITextField!
    @IBOutlet var yearField: UITextField!
    @IBOutlet var ratingField: UITextField!
    @IBOutlet var whatsGoodField: UITextField!
    @IBOutlet var whatsBadField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    var movie: Movie!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleField.text = movie.title
        yearField.text = String(movie.year)
        ratingField.text = String(movie.rating)
        whatsGoodField.text = movie.whatWasGood
        whatsBadField.text = movie.whatWasBad
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: (movie.dateCreated))
        
        dateLabel.text = dateString
    }
}
