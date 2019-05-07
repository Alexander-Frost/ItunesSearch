//
//  SearchResultsTableViewController.swift
//  ItunesSearch
//
//  Created by Alex on 5/7/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    let searchResultsController = SearchResultController()

    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(){
        var resultType: ResultType!
        guard let searchTerm = searchBar.text else {return}
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            resultType = .software
            searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
                if let error = error {
                    print("There was an error: \(error)")
                } else {
                    self.tableView.reloadData()
                }
                return
            }
        case 1:
            resultType = .musicTrack
            searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
                if let error = error {
                    print("There was an error: \(error)")
                } else {
                    self.tableView.reloadData()
                }
                return
            }
        case 2:
            resultType = .movie
            searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
                if let error = error {
                    print("There was an error: \(error)")
                } else {
                    self.tableView.reloadData()
                }
                return
            }
        default:
            break
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        let searchResult = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
