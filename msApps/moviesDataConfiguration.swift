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
    
    init(title t: String?, image img: String?, rating r: Double?, releaseYear year: Int64?, genre g: [String]? ) {
        self.title = t
        self.image = img
        self.rating = r
        self.releaseYear = year
        self.genre = g
    }
    
}
