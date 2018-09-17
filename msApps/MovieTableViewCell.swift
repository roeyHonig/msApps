//
//  MovieTableViewCell.swift
//  msApps
//
//  Created by hackeru on 7 Tishri 5779.
//  Copyright © 5779 student.roey.honig. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var movieThumbNailImage: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    
    var specificMovieInfo: MovieHeader?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
