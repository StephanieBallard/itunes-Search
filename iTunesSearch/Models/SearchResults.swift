//
//  SearchResults.swift
//  iTunesSearch
//
//  Created by Stephanie Ballard on 5/4/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
