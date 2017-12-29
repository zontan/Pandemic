//
//  SecondViewController.swift
//  Pandemic Deck Tracker
//
//  Created by Zontan on 12/24/17.
//  Copyright © 2017 Zontan. All rights reserved.
//

import UIKit

class DiscardViewController: DeckSectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func getSection() -> [[City : Int]] {
        return [Deck.shared.discard]
    }
    
    override func getSectionNum() -> Int {
        return Deck.Section.Discard.rawValue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

