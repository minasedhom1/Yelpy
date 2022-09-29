//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    let refreshItem = UIAction(title: "Refresh", image: UIImage(systemName: "arrow.clockwise")) { (_) in
         // handle refresh
    }
    let deleteItem = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { (_) in
               // delete item
    }
    @IBAction func locationNavButton(_ sender: Any) {
        let menu = UIMenu(title: "Options", children: [deleteItem, refreshItem])
        
    }
    
    @IBOutlet weak var tableView: UITableView!

    var restaurantsArray: [Restaurant] = []
    var searchController: UISearchController!
    var filteredData: [Restaurant]!
    
    var isSearchBarEmpty: Bool {
         return searchController.searchBar.text?.isEmpty ?? true
       }
    
       var isFiltering: Bool {
         return searchController.isActive && !isSearchBarEmpty
       }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let r = restaurantsArray[indexPath.row]
            let detailViewController = segue.destination as! RestaurantDetailViewController
            detailViewController.r = r
        }
    }
    
    func loadMoreRestaurants() {
        
        
        API.getRestaurants(limit: self.restaurantsArray.count + 10) { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
            print(restaurants)
            self.restaurantsArray = restaurants
            self.tableView.reloadData() // reload data!
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == self.restaurantsArray.count {
            loadMoreRestaurants()
        }
    }
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.delegate = self
        tableView.dataSource = self
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self

        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false
        tableView.rowHeight = 150
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        getAPIData()
        
    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData() {
        API.getRestaurants(limit: 10) { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
            print(restaurants)
            self.restaurantsArray = restaurants
            self.tableView.reloadData() // reload data!
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    if let searchText = searchController.searchBar.text {
           filteredData = restaurantsArray.filter { (candy: Restaurant) -> Bool in
             return candy.name.lowercased().contains(searchText.lowercased())
           }
           
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
          return filteredData.count
        }
        print(restaurantsArray.count)
        return restaurantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create Restaurant cell
        let cell =  tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant: Restaurant
        if isFiltering {
          restaurant = filteredData[indexPath.row]
        } else {
          restaurant = restaurantsArray[indexPath.row]
        }
        //let restaurant = restaurantsArray[indexPath.row]
        
        cell.r = restaurant
    
        
        return cell
    }
    
}

// ––––– TODO: Create tableView Extension and TableView Functionality


