//
//  SearchViewModel.swift
//  iTunesSearch
//
//  Created by Sefa Çelik on 4.05.2022.
//

import Foundation

class SearchViewModel {
    
    private var pagingOption = 20
    private var pagingCount = 20
    var result: ItunesSearchResponse = ItunesSearchResponse()
    
    public init() {
        
    }
   
    func getSearchResults(searchText: String, completion: (() -> Void)? = nil) {
        
        if (pagingCount%pagingOption) != 0 {
            return
        }
        
        guard let fixedText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let url = URL(string: "https://itunes.apple.com/search?term=\(fixedText)&limit=\(pagingCount)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ItunesSearchResponse.self, from: data ?? Data() )
                    self.result = result
                    self.pagingCount = self.pagingCount + 20
                    print(result.resultCount)
                    completion?()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getResultItems() -> [Items] {
        return self.result.results ?? [Items]()
    }
    
    func getResultItemsCount() -> Int {
        return self.result.resultCount ?? 0
    }
    
    func resetPagingCount() {
        self.pagingCount = 20
    }
}
