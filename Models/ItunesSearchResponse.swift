//
//  ItunesResponse.swift
//  iTunesSearch
//
//  Created by Sefa Çelik on 4.05.2022.
//

import Foundation


struct ItunesSearchResponse: Codable {
    var resultCount: Int?
    var results: [Item]?
}

struct Item: Codable {
    var wrapperType: String?
    var kind: String?
    var artistName: String?
    var trackName: String?
    var releaseDate: String?
    var primaryGenreName: String
    var artworkUrl100: String?
}
