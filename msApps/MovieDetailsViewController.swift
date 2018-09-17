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
        if let str = movieDetails?.image {
            posterImg.sd_setImage(with: URL(string: str), completed: nil)
        } else {
            posterImg.image = #imageLiteral(resourceName: "icons8-clapperboard_filled")
        }
        
        if let str = movieDetails?.title {
            titleLabel.text = str
        } else {
            titleLabel.text = "Title not available"
        }
        
        if let dbl = movieDetails?.rating {
            let str = String(dbl)
            ratingLabel.text = str
        } else {
            ratingLabel.text = "Rating not available"
        }
        
        if let int = movieDetails?.releaseYear {
            let str = String(int)
            releaseYearLabel.text = str
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
    
    func deleteThisMovie(){
        print("delete this movie")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
