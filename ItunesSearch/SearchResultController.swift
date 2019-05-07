//
//  SearchResultController.swift
//  ItunesSearch
//
//  Created by Alex on 5/7/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // MARK: Constants
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    // MARK: - Search
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void){
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchItem = URLQueryItem(name: "term", value: searchTerm)
        let searchType = URLQueryItem(name: "entity", value: resultType.rawValue)
        
        urlComponents?.queryItems = [searchItem, searchType]
        
        guard let urlRequest = urlComponents?.url else {
            print(NSError(), "There was an error fetching the urlComponents.")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: urlRequest)
        request.httpMethod = HTTPMethod.get.rawValue // call GET method
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            let jsonDecoder = JSONDecoder()

            if let error = error {
                print("There was an error fetching data in URLSession", error)
                return
            }
            guard let data = data else {
                print("There was an error fetching data.", error)
                return
            }

            do {
                let myResults = try jsonDecoder.decode(SearchResults.self, from: data).results
                self.searchResults = myResults
                return
            } catch {
                print("There was an error decoding data.", error)
                return
            }}.resume()
    }
}
