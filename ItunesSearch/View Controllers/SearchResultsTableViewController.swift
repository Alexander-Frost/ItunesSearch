//
//  SearchResultsTableViewController.swift
//  ItunesSearch
//
//  Created by Alex on 5/7/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    // MARK: Constants
    
    let searchResultsController = SearchResultController()

    // MARK: Outlets
    
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: Actions
    
    @objc func segmentControlPressed(sender: UISegmentedControl){
        searchBarSearchButtonClicked(searchBar)
        print("Clicked segmented control.")
    }
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set search bar delegate
        searchBar.delegate = self
        
        segmentControl.addTarget(self, action: #selector(segmentControlPressed(sender:)), for: .touchUpInside)
    }
    
    // MARK: Search
    
    func searchBarSearchButtonClicked(_: UISearchBar){
        
        // holds segment control selection
        var resultType: ResultType!
        
        // set search term
        guard let searchTerm = searchBar.text else {return}
        
        // setup types of searches
        switch segmentControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
        
        // call search function
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType, completion:{error in
            
            if let error = error {
                print("There was an error: \(error)")
            } else {
                print("performSearch has run.")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        }})
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        // get the array result at our index path
        let searchResult = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        return cell
    }

}
