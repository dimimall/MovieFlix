//
//  ViewController.swift
//  MovieFlix
//
//  Created by Δήμητρα Μαλλιαρου on 16/2/25.
//

import UIKit
import SwiftUI


class ViewController: UIViewController, SkeletonDisplayable{

    var https = Https()
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    private var cellReuseIdentifier: String! {
        return "CellIdentifier"
    }
    
    var popularMovies: [PopularMovie] = []
    
    let refreshControl = UIRefreshControl()
    
    var searchedResults: [PopularMovie] = []
    
    var idMovie: Int?
    
    // This is a flag that determines if to show all the results or only the searched results
    var isSearching = false {
        didSet {
            tableView.reloadData() // Reload the data if the flag changes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(
            UINib(nibName: "TableViewCell", bundle: nil),
            forCellReuseIdentifier: cellReuseIdentifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 210.0
        tableView.rowHeight = 210.0
        
        searchBar.delegate = self
        
        refreshControl.addTarget(self, action:  #selector(sortArray), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        
        https.fetchPopularMoviesTMDB(page:1,completion: {
            popularMovies in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5)  {
                self.popularMovies = popularMovies.results
                self.searchedResults = popularMovies.results
                self.tableView.reloadData()
                self.hideSkeleton()
            }
        })
        
    }
    
    @IBAction func favoritesAction(_ sender: UIBarButtonItem) {
        
    }
    
    
    func activeDataset() -> [PopularMovie] {
        if isSearching {
            return searchedResults
        } else {
            return popularMovies
        }
    }

    /// Returns a list of univerties matching given query
    func filteredUniversities(query: String) -> [PopularMovie] {
        return (popularMovies.filter { $0.original_title!.contains(query) })
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if searchedResults.isEmpty {
            showSkeleton()
        }
    }
    
    @objc func sortArray() {
        
        https.fetchPopularMoviesTMDB(page:2,completion: {
            popularMovies in
            DispatchQueue.main.asyncAfter(deadline: .now() + 7)  {
                self.popularMovies = popularMovies.results
                self.searchedResults = self.popularMovies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        })
    }
    
    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeDataset().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! TableViewCell
        
        
        cell.imageCell.imageFromServerURL("https://image.tmdb.org/t/p/original/\(searchedResults[indexPath.row].backdrop_path!)", placeHolder: UIImage(systemName: "star"))
        cell.imageUrl = "https://image.tmdb.org/t/p/original\(searchedResults[indexPath.row].backdrop_path!)"
        cell.titleCell.text = searchedResults[indexPath.row].original_title
        cell.releaseDateCell.text = searchedResults[indexPath.row].release_date
                        
        cell.starRatingCell.selectedStars = Int(searchedResults[indexPath.row].vote_average!)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idMovie = searchedResults[indexPath.row].id
        
        let swiftUIView = SwiftUIViewDetails()
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.rootView.id = idMovie
        hostingController.modalPresentationStyle = .formSheet
        hostingController.modalTransitionStyle = .flipHorizontal
        self.present(hostingController, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Check if the searched text has at least 1 character otherwise show all results
        guard searchText != "" else {
            isSearching = false
            searchedResults.removeAll()
            return
        }
        
        searchedResults = filteredUniversities(query: searchText)
        isSearching = true
    }
}

extension UIImageView {
    
        func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {

        self.image = nil
        //If imageurl's imagename has space then this line going to work for this
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        

        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                       
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
