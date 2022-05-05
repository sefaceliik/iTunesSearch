//
//  DetailViewModel.swift
//  iTunesSearch
//
//  Created by Sefa Çelik on 5.05.2022.
//

import Foundation

class DetailViewModel {
    
    private var model: Items?
    
    public init(model: Items? = nil) {
        self.model = model
    }
    
    func getSongName() -> String? {
        return model?.trackName
    }
    
    func getArtistName() -> String? {
        return model?.artistName
    }
    
    func getGenre() -> String? {
        return model?.primaryGenreName
    }
    
    func getReleaseDate() -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let date = dateFormatter.date(from: self.model?.releaseDate ?? "") ?? Date()
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM yyyy"
        
        return dateFormatterPrint.string(from: date)
    }
    
    func getImageUrl() -> String? {
        return model?.artworkUrl100
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
