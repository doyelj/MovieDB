//
//  Movie.swift
//  MovieDB
//
//  Created by Doyel Joboy on 9/6/18.
//  Copyright © 2018 UST. All rights reserved.
//

import Foundation

class Movie {
    
    var title :String
    var overview :String
    var vote_average :Double
    var poster_path :String
    
    init(title :String, overview: String, vote_average: Double,poster_path: String) {
        self.title = title
        self.overview = overview
        self.vote_average = vote_average
        self.poster_path = poster_path
    }
    
    init?(dictionary :JSONDictionary) {
        
        guard let title         = dictionary[Constants.kKEY_title] as? String,
            let overview        = dictionary[Constants.kKEY_overview] as? String,
            let vote_average    = dictionary[Constants.kKEY_vote_average] as? Double,
            let poster_path     = dictionary[Constants.kKEY_poster_path] as? String else {
                return nil
        }
        self.title = title
        self.overview = overview
        self.vote_average = vote_average
        self.poster_path = poster_path
    }
    
}
