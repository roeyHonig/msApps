//
//  MovieListViewController.swift
//  msApps
//
//  Created by hackeru on 7 Tishri 5779.
//  Copyright © 5779 student.roey.honig. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var moviesListDataSource: [MovieHeader] = []
    
    @IBAction func addMovieViaQRCode(_ sender: UIBarButtonItem) {
        print("adding a movie")
    }
    
    @IBOutlet var moviesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesListDataSource.count // should read core data
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieTableViewCell
        if let str = moviesListDataSource[indexPath.row].title , let int = moviesListDataSource[indexPath.row].releaseYear {
            cell.movieTitleLabel.text = "(\(int)) " + str
        }
        
        if let str = moviesListDataSource[indexPath.row].image {
            cell.movieThumbNailImage.sd_setImage(with: URL(string: str), completed: nil)
        } else {
            cell.movieThumbNailImage.image = #imageLiteral(resourceName: "icons8-clapperboard_filled")
        }
        
        cell.specificMovieInfo = moviesListDataSource[indexPath.row]
        
        /*
        var imgUrlAsString = ""
        if moviesListDataSource[indexPath.row].image != nil {
            imgUrlAsString = moviesListDataSource[indexPath.row].image as! String
        }
        let imageURL = URL(string: imgUrlAsString)
        cell.movieThumbNailImage.sd_setImage(with: imageURL, completed: nil)
         */
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destination is MovieDetailsViewController {
            // next screen is the movies Details
            let movieDetailsScreen = segue.destination as! MovieDetailsViewController
            let cell = sender as! MovieTableViewCell
            movieDetailsScreen.movieDetails = cell.specificMovieInfo
        }
    }
    

}
