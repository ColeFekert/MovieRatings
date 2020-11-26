//
//  Movie.swift
//  MovieRatings
//
//  Created by Cole Fekert on 11/3/20.
//

import Foundation

class Movie: NSObject, NSCoding {
    var title: String
    var rating: Int
    var year: Int
    var whatWasGood: String?
    var whatWasBad: String?
    var whoWatched: String
    
    let dateCreated: Date
    
    let movieKey: String
    
    var ratingChanged: Bool
    
    required init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        rating = aDecoder.decodeObject(forKey: "rating") as! Int
        year = aDecoder.decodeObject(forKey: "year") as! Int
        whatWasGood = aDecoder.decodeObject(forKey: "whatWasGood") as! String
        whatWasBad = aDecoder.decodeObject(forKey: "whatWasBad") as! String
        whoWatched = aDecoder.decodeObject(forKey: "whoWatched") as! String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
        movieKey = aDecoder.decodeObject(forKey: "movieKey") as! String
        ratingChanged = aDecoder.decodeObject(forKey: "ratingChanged") as! Bool
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(rating, forKey: "rating")
        aCoder.encode(year, forKey: "year")
        aCoder.encode(whatWasGood, forKey: "whatWasGood")
        aCoder.encode(whatWasBad, forKey: "whatWasBad")
        aCoder.encode(whoWatched, forKey: "whoWatched")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(movieKey, forKey: "movieKey")
        aCoder.encode(ratingChanged, forKey: "ratingChanged")
    }
    
    init(title: String, rating: Int, year: Int, whatWasGood: String?, whatWasBad: String?, whoWatched: String) {
        self.title = title
        self.rating = rating
        self.year = year
        self.whatWasGood = whatWasGood
        self.whatWasBad = whatWasBad
        self.whoWatched = whoWatched
        
        self.dateCreated = Date()
        
        self.movieKey = UUID().uuidString
        
        self.ratingChanged = false
        
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            // Arrays to supply random entries
            let adjectives = ["Shocking", "Insane", "Regular", "Spooky", "Uneventful", "Lame", "Bloody"]
            let nouns = ["Rambo", "Road", "Terry", "Alien", "Day", "Town", "City", "World"]
            
            let goods = ["give up gambling", "take up hobbiest woodcarving", "call my mom"]
            let bads = ["ruined", "had no effect", "made me revaluate"]
            
            let watchers = ["Cole Fekert", "Terry Tate", "Gordon Freeman", "Papa Johns", "The Cool Aid Man"]
            
            // Random generators
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            idx = arc4random_uniform(UInt32(goods.count))
            let randomGood = goods[Int(idx)]
            
            idx = arc4random_uniform(UInt32(bads.count))
            let randomBad = bads[Int(idx)]
            
            idx = arc4random_uniform(UInt32(watchers.count))
            let randomWatcher = watchers[Int(idx)]
            
            // Setters
            let randomTitle = "\(randomAdjective) \(randomNoun)"
            let randomRating = Int(arc4random_uniform(11))
            let randomYear = Int(arc4random_uniform(100)) + 1920
            let randomWhatWasGood = "This movie made me \(randomGood)."
            let randomWhatWasBad = "However, it also \(randomBad) my life."
            let randomWhoWatched = "\(randomWatcher)"
            
            // Initializer
            self.init(title: randomTitle, rating: randomRating, year: randomYear, whatWasGood: randomWhatWasGood, whatWasBad: randomWhatWasBad, whoWatched: randomWhoWatched)
        } else {
            self.init(title: "", rating: 0, year: 0, whatWasGood: "Sample text.", whatWasBad: "Sample text.", whoWatched: "")
        }
    }
    
    func changeRating(desiredRating: Int) {
        ratingChanged = true
        
        rating = desiredRating
    }
    
    func finishedChangingRating() {
        ratingChanged = false
    }
}
