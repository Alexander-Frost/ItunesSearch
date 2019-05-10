//
//  SearchResult.swift
//  ItunesSearch
//
//  Created by Alex on 5/7/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    // names of the actual keys in the data
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
