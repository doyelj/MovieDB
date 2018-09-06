//
//  MovieViewController.swift
//  MovieDB
//
//  Created by Doyel Joboy on 9/6/18.
//  Copyright © 2018 UST. All rights reserved.
//

import Foundation
import UIKit

class MovieViewController : UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache:NSCache<AnyObject, AnyObject>!
    
    var favouriteButtontag : Int = -1;
    var imageDictionary = [String: UIImage]()
  
    private var viewModel :MovieListViewModel = MovieListViewModel()  {
        didSet {
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action:
            #selector(MovieViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
        self.tableView.addSubview(self.refreshControl)
        tableView.accessibilityIdentifier = Constants.kAID_movieTableView;
        loadMovies()
    }
    /*
    This method is used to laod all top rated movies
    Argumnent   : NA
    Return type : Void
    After completion it will notify the observer to reload table view.
    */
    private func loadMovies() {
        let url = URL(string: Constants.kURL_GetTopRatedMovies)!
        Webservice().getMovies(url: url) { movies in
            let movies = movies.map { movie in
                return MovieViewModel(movie :movie)
            }
            self.viewModel = MovieListViewModel(movies :movies)
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadMovies()
    }
    
}
extension MovieViewController: UITableViewDelegate,UITableViewDataSource {
    // MARK: table view delegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = self.viewModel.movies[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = Constants.kCELL_Movie
        if(self.viewModel.movies.count==0)
        {
            let emptyCell = tableView.dequeueReusableCell(withIdentifier: identifier ,for: indexPath) as! MoviesTableViewCell
            return emptyCell;
        }
        else
        {
            let cell: MoviesTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier ,for: indexPath) as! MoviesTableViewCell
            let MovieViewModel = self.viewModel.movies[indexPath.row]
            cell.titleLabel.text = MovieViewModel.title;
            cell.overViewTextView.text = MovieViewModel.overview;
            cell.ratingLabel.text = String(MovieViewModel.vote_average);
            cell.overViewTextView.scrollRangeToVisible(NSMakeRange(0,0))
            let imageUrl = Constants.kURL_Image + MovieViewModel.poster_path;
            cell.movieImageView.image = UIImage(named: Constants.kIMAGE_spinner)
            let favImage = (favouriteButtontag == indexPath.row) ? Constants.kIMAGE_favourite:Constants.kIMAGE_favouriteDisabled;
            cell.favouriteImageView.image = UIImage(named: favImage)
            cell.movieImageView.contentMode = .center
            cell.favouriteButton.tag = indexPath.row;
            cell.favouriteButton.accessibilityIdentifier = Constants.kAID_favouritebutton;
            cell.favouriteButton.addTarget(self, action: #selector(callClicked(sender:)), for: .touchUpInside)
            if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
                // Cached image used, no need to download it
                cell.movieImageView.contentMode = .scaleAspectFit
                cell.movieImageView.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
            }else{
                let url:URL! = URL(string: imageUrl)
                task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                    if let data = try? Data(contentsOf: url){
                        DispatchQueue.main.async(execute: { () -> Void in
                            // Before we assign the image, check whether the current cell is visible
                            if tableView.cellForRow(at: indexPath) != nil {
                                let img:UIImage! = UIImage(data: data)
                                cell.movieImageView.contentMode = .scaleAspectFit
                                cell.movieImageView.image  = img;
                                self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
                            }
                        })
                    }
                })
                task.resume()
            }
            
            return cell
        }
    }
    // MARK: cell tap methods
    /*
     This method is used select/unselect favourites movies
     Argumnent   : UIButton
     Return type : Void
     After completion it will modify the tableview cell UI
     */
    @objc func callClicked(sender:UIButton) {
        var indexPath = IndexPath(row: sender.tag, section: 0)
        if tableView.cellForRow(at: indexPath) != nil {
            let cell = tableView.cellForRow(at: indexPath) as! MoviesTableViewCell
            cell.favouriteImageView.image = UIImage(named: Constants.kIMAGE_favourite)
        }
        // unselecting the previos selected favourite cell
        if(favouriteButtontag >= 0){
            indexPath = IndexPath(row: favouriteButtontag, section: 0)
            if tableView.cellForRow(at: indexPath) != nil {
                let cell = tableView.cellForRow(at: indexPath) as! MoviesTableViewCell
                cell.favouriteImageView.image = UIImage(named: Constants.kIMAGE_favouriteDisabled)
                
            }
        }
        favouriteButtontag = (sender.tag == favouriteButtontag) ? -1 : sender.tag;
    }
    
}
