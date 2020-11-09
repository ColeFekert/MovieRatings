//
//  Movie.swift
//  MovieRatings
//
//  Created by Cole Fekert on 11/3/20.
//

import Foundation

class Movie: NSObject {
    var title: String
    var rating: Int
    var year: Int
    var whatWasGood: String?
    var whatWasBad: String?
    var whoWatched: String
    
    let dateCreated: Date
    
    init(title: String, rating: Int, year: Int, whatWasGood: String?, whatWasBad: String?, whoWatched: String) {
        self.title = title
        self.rating = rating
        self.year = year
        self.whatWasGood = whatWasGood
        self.whatWasBad = whatWasBad
        self.whoWatched = whoWatched
        
        self.dateCreated = Date()
        
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
}
