//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Stephanie Ballard on 5/4/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
       case get = "GET"
       case put = "PUT"
       case post = "POST"
       case delete = "DELETE"
   }

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    private lazy var jsonDecoder = JSONDecoder()
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping() -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let titleQueryItem = URLQueryItem(name: "term", value: searchTerm)
        
        urlComponents?.queryItems = [titleQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        print(request)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned from data task")
                return
            }
            
            do {
                let itunesSearch = try self.jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = itunesSearch.results
            } catch {
                print("Unable to decode data into object of type [SearchResults]: \(error)")
            }
            completion()
        }.resume()
        
    }
}
