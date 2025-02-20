//
//  FavoriteCell.swift
//  MovieFlix
//
//  Created by Δήμητρα Μαλλιαρου on 19/2/25.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    @IBOutlet var releaseDateFav: UILabel!
    @IBOutlet var titleFavorite: UILabel!
    @IBOutlet var favoriteImage: UIImageView!
    
    @IBOutlet var startRatingCell: StarRating!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
