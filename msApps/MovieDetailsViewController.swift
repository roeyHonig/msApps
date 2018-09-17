//
//  MovieDetailsViewController.swift
//  msApps
//
//  Created by hackeru on 7 Tishri 5779.
//  Copyright © 5779 student.roey.honig. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController{
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var releaseYearLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var posterImg: UIImageView!
    
    @IBAction func deleteThisMovieFromTheAppDataBase(_ sender: UIBarButtonItem) {
        deleteThisMovie()
    }
    
    var movieDetails: MovieHeader?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Movie Details" // consider to delete
        // init all the movie details
        initDisplayElementsOfThisScreen()
        
    }
    
    func deleteThisMovie(){
        showInputDialog(withMessage: "Are You Sure you want to delete this movie from your list?")
    }
    
    func showInputDialog(withMessage str: String?) {
        let alertController = UIAlertController(title: "Warning", message: str, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { (uiAlertAction) in
            // upon completion
            guard let movieToBeDeleted = self.movieDetails else {return}
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            appDelegate.deletingThisMovieFromCoreData(attribute: "title", whosValue: movieToBeDeleted.title!)
            
            // pass the newlly read core data to the data source of the previus screen
            let movListView = self.navigationController?.viewControllers[0] as! MovieListViewController
            movListView.moviesListDataSource = appDelegate.getMoviesFromCoreData()
            // return to previus screen screen
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (uiAlertAction) in
            
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true) {
            // upon completion
        }
    }

    func initDisplayElementsOfThisScreen() {
        if let str = movieDetails?.image {
            posterImg.sd_setImage(with: URL(string: str), completed: nil)
        } else {
            posterImg.image = #imageLiteral(resourceName: "icons8-clapperboard_filled")
        }
        
        if let str = movieDetails?.title {
            titleLabel.text = "Title: " + str
        } else {
            titleLabel.text = "Title not available"
        }
        
        if let dbl = movieDetails?.rating {
            let str = String(dbl)
            ratingLabel.text = "Rating: " + str
        } else {
            ratingLabel.text = "Rating not available"
        }
        
        if let int = movieDetails?.releaseYear {
            let str = String(int)
            releaseYearLabel.text = "Year Of Release: " + str
        } else {
            releaseYearLabel.text = "Year Of Release not available"
        }
        
        if let strArray = movieDetails?.genre {
            var str = "Genre: "
            
            for i in 0...(strArray.count-1) {
                if i == 0 {
                    str = str + strArray[i]
                } else {
                    str = str + ", " + strArray[i]
                }
            }
            genreLabel.text = str
        } else {
            genreLabel.text = "Genres not available"
        }
    }
    
    

}
