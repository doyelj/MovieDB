//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by Doyel Joboy on 9/6/18.
//  Copyright © 2018 UST. All rights reserved.
//

import Foundation


struct MovieListViewModel {
    
    var title :String? = Constants.kVAL_null
    var movies :[MovieViewModel] = [MovieViewModel]()
}

extension MovieListViewModel {
    
    init(movies :[MovieViewModel]) {
        self.movies = movies
    }
    
}

struct MovieViewModel {
    
    var title :String
    var poster_path :String
    var overview :String
    var vote_average :Double
}

extension MovieViewModel {
    
    init(movie :Movie) {
        self.title = movie.title
        self.poster_path = movie.poster_path
        self.overview = movie.overview
        self.vote_average = movie.vote_average
    }
}
