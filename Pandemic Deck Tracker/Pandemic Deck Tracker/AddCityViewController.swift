//
//  AddCityViewController.swift
//  Pandemic Deck Tracker
//
//  Created by Jonathan  Fotland on 12/29/17.
//  Copyright © 2017 Zontan. All rights reserved.
//

import UIKit

class AddCityViewController: UITableViewController, UISearchResultsUpdating {
   
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCities = Deck.additionalCities.filter({( city : City) -> Bool in
            return city.cityName.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }

    // MARK: - Search Controller Methods
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    

    // MARK: - Table View Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCities.count
        }
        
        return Deck.additionalCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let city: City
        if isFiltering() {
            city = filteredCities[indexPath.row]
        } else {
            city = Deck.additionalCities[indexPath.row]
        }
        cell.textLabel!.text = city.cityName
        //cell.detailTextLabel!.text = candy.category
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let city: City
        if isFiltering() {
            city = filteredCities[indexPath.row]
        } else {
            city = Deck.additionalCities[indexPath.row]
        }
        
        if Deck.shared.cityList.contains(city) {
            //TODO: Figure out what makes sense here
        } else {
            Deck.shared.add(card: city, to: Deck.Section.Removed.rawValue)
            Deck.saveCities()
            navigationController?.popViewController(animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
