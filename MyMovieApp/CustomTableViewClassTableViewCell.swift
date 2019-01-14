//
//  CustomTableViewClassTableViewCell.swift
//  MyMovieApp
//
//  Created by Dalvin Sejour on 1/11/19.
//  Copyright © 2019 Dalvin Sejour. All rights reserved.
//

import UIKit

class CustomTableViewClassTableViewCell: UITableViewCell {

        @IBOutlet var movieImageView: UIImageView!
        @IBOutlet var movieTitle: UILabel!
        @IBOutlet var movieYear: UILabel!
        @IBOutlet var favButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
