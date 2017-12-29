//
//  FirstViewController.swift
//  Pandemic Deck Tracker
//
//  Created by Zontan on 12/24/17.
//  Copyright © 2017 Zontan. All rights reserved.
//

import UIKit

class DeckTopViewController: DeckSectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib.init(nibName: "CityTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cityCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func getSection() -> [[City : Int]] {
        return [Deck.shared.sections[0]]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = Deck.sortedCityList(section: Deck.shared.sections[0])
        
        let city = list[indexPath.row]
        let num = Deck.shared.sections[0][city]
        
        if num! > 1 {
            Deck.shared.sections[0][city] = num! - 1
        } else {
            Deck.shared.sections[0][city] = nil
        }
        
        if city.supplyCubes > 0 {
            city.supplyCubes -= 1
        }
        
        if Deck.shared.sections[0].isEmpty {
            Deck.shared.sections.remove(at: 0)
        }
        
        if let discardNum = Deck.shared.discard[city] {
            Deck.shared.discard[city] = discardNum + 1
        } else {
            Deck.shared.discard[city] = 1
        }
        
        tableView.reloadData()
    }
    
}

