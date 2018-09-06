//
//  Constants.swift
//  MovieDB
//
//  Created by Doyel Joboy on 9/6/18.
//  Copyright © 2018 UST. All rights reserved.
//

import Foundation
struct Constants {
    
    // URL
    static let kURL_GetTopRatedMovies     =   "https://api.themoviedb.org/3/movie/top_rated?api_key=8a8af28bee9144d35fa4c86fdf664df3&language=en-US"
    static let kURL_Image                 =   "https://image.tmdb.org/t/p/w300"
    
    // cell Identifiers
    static let kCELL_Movie                =    "moviecell"
    
    // KEY path for kURLGetTopRatedMovies
    static let kKEY_results              =    "results"
    static let kKEY_title                =    "title"
    static let kKEY_overview             =    "overview"
    static let kKEY_vote_average         =    "vote_average"
    static let kKEY_poster_path          =    "poster_path"
   
    // default values
    static let kVAL_null                 =    ""
    
    // Image sets
    static let kIMAGE_favourite           =    "favorite"
    static let kIMAGE_favouriteDisabled   =    "Favourite_disabled"
    static let kIMAGE_spinner             =    "spinner"
    
    // accessibilityIdentifier
    static let kAID_movieTableView         =    "table--movieTableView"
    static let kAID_favouritebutton        =    "favouritebutton"
    
}
