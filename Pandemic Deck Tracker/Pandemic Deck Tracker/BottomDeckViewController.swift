//
//  BottomDeckViewController.swift
//  Pandemic Deck Tracker
//
//  Created by Zontan on 12/24/17.
//  Copyright © 2017 Zontan. All rights reserved.
//

import UIKit

class BottomDeckViewController: DeckSectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func getSection() -> [[City : Int]] {
        var sectionCopy = Deck.shared.sections
        sectionCopy.remove(at: 0)
        return sectionCopy
    }
    
    override func getSectionNum() -> Int {
        return 1
    }

}
