//
//  TableViewCell.swift
//  MovieFlix
//
//  Created by Δήμητρα Μαλλιαρου on 16/2/25.
//

import UIKit
import CoreData
import Foundation

class TableViewCell: UITableViewCell {

    @IBOutlet var imageCell: UIImageView!
    
    @IBOutlet var titleCell: UILabel!
    
    @IBOutlet var releaseDateCell: UILabel!
    
    @IBOutlet var starRatingCell: StarRating!
    
    @IBOutlet var favoriteBtn: UIButton!
    
    var imageUrl: String? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        favoriteBtn.addTarget(self, action: #selector(favoriteAction(_:)), for: .touchUpInside)
    }

    var popularMovieData: PopularMovie? {
        didSet {
            setupCell()
        }
    }
    
    @objc func favoriteAction(_ sender: UIButton) {
        CoreDataHelper.shared.fetchCoreData(onSuccess: {
            favorities in
            if !(favorities!.isEmpty) {
                for favorite in favorities! {
                    if favorite.title == self.titleCell.text {
                        print("title \(favorite.title ?? "") \(self.titleCell.text ?? "")")
                    }
                    else {
                        print("list is not empty add another element")
                        CoreDataHelper.shared.saveImage(image: self.imageUrl ?? "", title: self.titleCell.text ?? "", release_date: self.releaseDateCell.text ?? "", rating: Float(self.starRatingCell.selectedStars))
                        self.favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    }
                }
            }
            else {
                print("first element")
                CoreDataHelper.shared.saveImage(image: self.imageUrl ?? "", title: self.titleCell.text ?? "", release_date: self.releaseDateCell.text ?? "", rating: Float(self.starRatingCell.selectedStars))
                self.favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        })
    }
    

    private func setupCell() {
        guard let popularMovieData = popularMovieData else { return }
        imageCell.image = UIImage(systemName: "star")
        titleCell.text = popularMovieData.original_title
        releaseDateCell.text = popularMovieData.release_date
        
    }
    
}
