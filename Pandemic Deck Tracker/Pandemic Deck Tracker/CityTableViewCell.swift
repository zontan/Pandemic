//
//  CityTableViewCell.swift
//  Pandemic Deck Tracker
//
//  Created by Zontan on 12/24/17.
//  Copyright © 2017 Zontan. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cubeCounter: UIStepper!
    @IBOutlet weak var cubesLabel: UILabel!
    @IBOutlet weak var dangerIcon: UIImageView!
    @IBOutlet weak var dangerTimer: UILabel!
    
    var city: City!
    var controller: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func valueChanged(_ sender: Any) {
        setCubes(cubes: Int(cubeCounter.value))
    }

    func setCubes(cubes: Int) {
        city.supplyCubes = cubes
        cubesLabel.text = "Supply Cubes: \(cubes)"
        cubeCounter.value = Double(cubes)
    }
    @IBAction func wasLongPressed(_ sender: Any) {
        let alert = UIAlertController.init(title: "Remove Card", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction.init(title: "Remove From Game", style: .default, handler: { (action) in
            
        }))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
