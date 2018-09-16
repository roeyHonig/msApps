//
//  ViewController.swift
//  msApps
//
//  Created by hackeru on 7 Tishri 5779.
//  Copyright © 5779 student.roey.honig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var movieCollection: [MovieHeader] = []
    
    
    @IBAction func writeDirectllyToCoreData(_ sender: UIButton) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let q = DispatchQueue.global(qos: .userInteractive)
        q.async {
            // save manually to coredata
            appDelegate.saveMovie(name: "roey inviation", imageAdress: nil, reportedRatings: nil, releasedOn: nil, classifiedAs: ["drama" , "comedy"])
            // read the coredata
            self.movieCollection = appDelegate.getMoviesFromCoreData()
            // goto next screen
            DispatchQueue.main.async {
                // performe segue
                print("going tro next screen")
                self.performSegue(withIdentifier: "goToMovieListSegue", sender: self)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

