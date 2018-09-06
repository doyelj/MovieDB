//
//  Webservice.swift
//  MovieDB
//
//  Created by Doyel Joboy on 9/6/18.
//  Copyright © 2018 UST. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String:Any]

class Webservice {
    
    func getMovies(url :URL, callback :@escaping ([Movie]) -> ()) {
        
        var movies = [Movie]()
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let dictionary = json as! JSONDictionary
                
                let movieDictionaries = dictionary[Constants.kKEY_results] as! [JSONDictionary]
                
                movies = movieDictionaries.compactMap { dictionary in
                    return Movie(dictionary :dictionary)
                }
            }
            
            DispatchQueue.main.async {
                callback(movies)
            }
            
            }.resume()
        
    }
    
}
