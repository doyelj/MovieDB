//
//  MoviesTableViewCell.swift
//  MovieDB
//
//  Created by Doyel Joboy on 9/6/18.
//  Copyright © 2018 UST. All rights reserved.
//

import Foundation
import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet var favouriteButton: UIButton!
    @IBOutlet var favouriteImageView: UIImageView!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var overViewTextView: UITextView!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
