//
//  ViewController.swift
//  msApps
//
//  Created by hackeru on 7 Tishri 5779.
//  Copyright © 5779 student.roey.honig. All rights reserved.
//
//This is the correct format for generating QR Code using a text string to be later read by the QR scanner and correctlly decoded
//   {"title":"Planet of the Apes","genre":["Action"],"image":"https:\/\/api.androidhive.info\/json\/movies\/1.jpg","rating":8.300000000000001,"releaseYear":2019}

import UIKit

class ViewController: UIViewController {
    
    var movieCollection: [MovieHeader] = []
    @IBOutlet var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIView.animate(withDuration: 1, delay: 0, options: [UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat ], animations: {
            self.welcomeLabel.alpha = 0
        }, completion: { (bool) in
            // upon completion
        })
        
        UIView.animate(withDuration: 6, delay: 0, options: [], animations: {
            self.view.alpha = 0.999 // insignicant change, just to make the animation runs
        }, completion: { (bool) in
            // upon completion
            self.parseJsonFromFollowing(url: "https://api.androidhive.info/json/movies.json")
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is UINavigationController {
           print("prepere")
            // next screen is the movies list
            let movieList = (segue.destination as! UINavigationController).viewControllers[0] as! MovieListViewController
            movieList.moviesListDataSource = movieCollection
        }
    }

    func parseJsonFromFollowing(url apiUrl: String) {
        getMovieHeaderAPI(apiAddress: apiUrl)  {(resultedMovieHeaderApi) in
            // callback code
            self.movieCollection = resultedMovieHeaderApi
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let q = DispatchQueue.global(qos: .userInteractive)
            q.async {
                // save manually to coredata
                for movie in self.movieCollection {
                    appDelegate.saveMovie(name: movie.title, imageAdress: movie.image, reportedRatings: movie.rating, releasedOn: movie.releaseYear, classifiedAs: movie.genre)
                }
                // read the coredata
                self.movieCollection = appDelegate.getMoviesFromCoreData()
                // goto next screen
                DispatchQueue.main.async {
                    // performe segue
                    self.performSegue(withIdentifier: "goToMovieListSegue", sender: self)
                }
            }
        }
    }
    
    func parseJsonFromFollowing(String str: String) {
        getMovieHeaderFromJSONText(FromJSONText: str) { (resultMovieHeader) in
            print(resultMovieHeader.title!)
        }
    }
    

}

