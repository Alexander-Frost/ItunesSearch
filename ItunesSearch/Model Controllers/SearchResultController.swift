//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by Alex on 5/7/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // MARK: - Constants
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    // MARK: - Search
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void){
        
        // 1. build base URL to use
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQuery = URLQueryItem(name: "term", value: searchTerm)
        let resultQuery = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchQuery, resultQuery]
        
        // 2. now that we have the url, create the url request
        guard let urlRequest = urlComponents?.url else  {return completion(nil)}
        
        // 3. choose method to transmit and configure to do so
        var request = URLRequest(url: urlRequest)
        request.httpMethod = "GET"
        
        // 4. request data
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            // check for errors and data
            if let error = error {
                print("There was an error requesting data")
                return completion(error)
            }
            guard let data = data else {
                print("There was an error getting data.", error)
                completion(NSError())
                return
            }
            
            // if we got our data back, we need to decode it to match our model object
            let jsonDecoder = JSONDecoder()

            do {
                // 1. decode results into array
                let results = try jsonDecoder.decode(SearchResults.self, from: data).results
                
                // 2. set search results var equal to our decoded results array
                self.searchResults = results
                
                completion(nil)
            } catch {
                print("There was an error decoding data.", error)
                completion(error)
            }}.resume()
    }
}
