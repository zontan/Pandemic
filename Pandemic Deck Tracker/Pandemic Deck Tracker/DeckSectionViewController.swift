//
//  DeckSectionViewController.swift
//  Pandemic Deck Tracker
//
//  Created by Zontan on 12/24/17.
//  Copyright © 2017 Zontan. All rights reserved.
//

import UIKit

class DeckSectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var selectedCity: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib.init(nibName: "CityTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cityCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getSection() -> [[City: Int]] {
        return [[:]]
    }
    
    func removeCityCard(city: City) {
        
    }
    
    //Table View Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return getSection().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  getSection()[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let list = Deck.sortedCityList(section: getSection()[indexPath.section])
        
        let city = list[indexPath.row]
        let num = getSection()[indexPath.section][city]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as! CityTableViewCell
        
        cell.city = city
        cell.controller = self
        
        if num! > 1 {
            cell.nameLabel.text = "\(city.cityName) (\(num!))"
        } else {
            cell.nameLabel.text = city.cityName
        }
        
        cell.setCubes(cubes: city.supplyCubes)
        
        return cell
    }
}
