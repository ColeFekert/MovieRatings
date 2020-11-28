//
//  DetailViewController.swift
//  MovieRatings
//
//  Created by Cole Fekert on 11/8/20.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var titleField: UITextField!
    @IBOutlet var yearField: UITextField!
    @IBOutlet var ratingField: UITextField!
    @IBOutlet var whatsGoodField: UITextField!
    @IBOutlet var whatsBadField: UITextField!
    @IBOutlet var whoWatchedField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var movie: Movie! {
        didSet {
            navigationItem.title = movie.title
        }
    }
    
    var imageStore: ImageStore!
    
    @IBAction func removePicture(_ sender: UIBarButtonItem) {
        imageView.image = nil
        
        imageStore.deleteImage(forKey: movie.movieKey)
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        // If the device has a camera, take a picture; otherwise, just pick from the photo library
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            imagePicker.sourceType = .camera
//        } else {
//            imagePicker.sourceType = .photoLibrary
//        }
        
        // Doesn't really make sense for the user to take a picture and have that as the image. They'll most likely download an image and use that.
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        // place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get picked image from info dictionary
        if let image = info[.originalImage] as? UIImage {
            // Store the image in the ImageStore for the movie's key
            imageStore.setImage(image, forKey: movie.movieKey)
            
            // Put that image on the screen in the image view
            imageView.image = image
            
            print("Added Image")
        }
        
        // Take image picker off the screen - you must call this dismiss method
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleField.text = movie.title
        yearField.text = String(movie.year)
        ratingField.text = String(movie.rating)
        whatsGoodField.text = movie.whatWasGood
        whatsBadField.text = movie.whatWasBad
        whoWatchedField.text = movie.whoWatched
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: (movie.dateCreated))
        
        dateLabel.text = dateString
        
        // Get the movieKey
        let key = movie.movieKey
        
        // If there's an associated image with the movie, display it on the image view
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let numberFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            
            return formatter
        }()
        
        // Clear first responder (keyboard)
        view.endEditing(true)
        
        // Save changes to movie
        movie.title = titleField.text ?? ""
        
        if let yearText = yearField.text, let year = numberFormatter.number(from: yearText) {
            movie.year = year.intValue
        } else {
            movie.year = 1919
        }
        if let ratingText = ratingField.text, let rating = numberFormatter.number(from: ratingText) {
            movie.changeRating(desiredRating: rating.intValue)
        } else {
            movie.changeRating(desiredRating: 5)
        }
        
        movie.whatWasGood = whatsGoodField.text ?? ""
        movie.whatWasBad = whatsBadField.text ?? ""
        movie.whoWatched = whoWatchedField.text ?? ""
        
        // TODO: Implement a way to track revisions.
        //       Maybe this could be made by making the dateCreated into an array of Movies called revisions. The latest one would be displayed in the place that the dateCreated is currently displayed. When the user taps on the displayed date it would break out into a modal where the user can select a date and see the different revisions.
        //  Would have to ask the user to save or discard their data after changing anything.
        //  It would be useful to display the changed strings in Who's watched with the revision date.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
