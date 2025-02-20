//
//  FavoritesController.swift
//  MovieFlix
//
//  Created by Δήμητρα Μαλλιαρου on 19/2/25.
//

import UIKit

class FavoritesController: UIViewController {

    @IBOutlet var favoritesTable: UITableView!
    
    var favoriteLists: [FavoriteMovie] = []
    
    
    var https = Https()
    
    private var cellReuseIdentifier: String! {
        return "CellIdentifier"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoritesTable.register(
            UINib(nibName: "FavoriteCell", bundle: nil),
            forCellReuseIdentifier: cellReuseIdentifier
        )
        
        favoritesTable.dataSource = self
        
        CoreDataHelper.shared.fetchCoreData(onSuccess: {
            favorities in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3)  {
                self.favoriteLists = favorities!
                self.favoritesTable.reloadData()
            }
        })
    }

}

extension FavoritesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! FavoriteCell
        
        cell.favoriteImage.imageFromServerURL(favoriteLists[indexPath.row].image_movie!, placeHolder: UIImage(systemName: "star.fill"))
        cell.titleFavorite.text = favoriteLists[indexPath.row].title
        cell.releaseDateFav.text = favoriteLists[indexPath.row].release_date
        cell.startRatingCell.selectedStars = Int(favoriteLists[indexPath.row].rating)
        
        return cell
    }
    
    
}
