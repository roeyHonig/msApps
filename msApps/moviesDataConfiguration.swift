//
//  moviesDataConfiguration.swift
//  msApps
//
//  Created by hackeru on 7 Tishri 5779.
//  Copyright © 5779 student.roey.honig. All rights reserved.
//

import Foundation

struct MovieHeader: Codable {
    var title: String?
    var image: String?
    var rating: Double?
    var releaseYear: Int64?
    var genre: [String]?
    
    enum codingKeys: String, CodingKey {
        case title = "title"
        case image = "image"
        case rating = "rating"
        case releaseYear = "releaseYear"
        case genre = "genre"
    }
    
    // normal init
    init(title t: String?, image img: String?, rating r: Double?, releaseYear year: Int64?, genre g: [String]? ) {
        self.title = t
        self.image = img
        self.rating = r
        self.releaseYear = year
        self.genre = g
    }
    
    // init from JSON
    init?(json: [String: Any]) {
        guard let t = json["title"] as? String,
            let img = json["image"] as? String,
            let r = json["rating"] as? Double,
            let year = json["releaseYear"] as? Int64,
            let g = json["genre"] as? [String] else {
                return nil
        }
        self.title = t
        self.image = img
        self.rating = r
        self.releaseYear = year
        self.genre = g
    }
}

struct MovieHeaderAPI: Codable {
    var rows: [MovieHeader]
}

let session = URLSession.shared // sheared session for the app
var myDataTask: URLSessionDataTask?

func getMovieHeaderAPI(apiAddress: String ,callback: @escaping ([MovieHeader])-> Void) {
    print("api")
    myDataTask?.cancel() // cancel any previus tasks
    
    // API web adress
    //var apiAddress = "https://api.androidhive.info/json/movies.json"
    let apiUrl = URL(string: apiAddress)!
    
    myDataTask = session.dataTask(with: apiUrl) { (data, res, err) in
        guard let data = data else {
            print("no data")
            return
        }
        // if we got here, we have data
        print(data)
        print(res)
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode([MovieHeader].self, from: data) else {return /*SHOW DIALOG*/}
        //guard let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
        // we have our object
        //let retrived
        
        // Run code on the UI Thread
        DispatchQueue.main.async {
            callback(result)
        }
    }
    
    myDataTask?.resume()
    
}

func getMovieHeaderFromJSONText(FromJSONText str: String ,callback: @escaping (MovieHeader)-> Void) {
    
        let jsonData = str.data(using: String.Encoding.utf8)!
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(MovieHeader.self, from: jsonData) else {return /*SHOW DIALOG*/}
        //guard let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
        // we have our object
        //let retrived
        
        // Run code on the UI Thread
        DispatchQueue.main.async {
            callback(result)
        }
    
    
    
    
}

let str = """
{
title: "Roey is amazing",
image: "https://api.androidhive.info/json/movies/1.jpg",
rating: 8.3,
releaseYear: 2014,
genre: [
"Action",
"Drama",
"Sci-Fi"
]
}
"""


/*
 
 
 {title: "Dawn of the Planet of the Apes",image: "https://api.androidhive.info/json/movies/1.jpg",rating: 8.3,releaseYear: 2014, genre: ["Action","Drama","Sci-Fi"]}
 
 
 */
