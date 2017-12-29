//
//  EpidemicAlertController.swift
//  Pandemic Deck Tracker
//
//  Created by Zontan on 12/24/17.
//  Copyright © 2017 Zontan. All rights reserved.
//

import UIKit

class EpidemicAlertController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var selectedCity: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressOK(_ sender: Any) {
        if let city = self.selectedCity {
            let num = Deck.shared.sections[Deck.shared.sections.count - 1][city]
            
            if num! > 1 {
                Deck.shared.sections[Deck.shared.sections.count - 1][city] = num! - 1
            } else {
                Deck.shared.sections[Deck.shared.sections.count - 1][city] = nil
            }
            
            city.supplyCubes = 0
            
            if let discardNum = Deck.shared.discard[city] {
                Deck.shared.discard[city] = discardNum + 1
            } else {
                Deck.shared.discard[city] = 1
            }
        }
        
        Deck.shared.sections.insert(Deck.shared.discard, at: 0)
        Deck.shared.discard.removeAll()
        
        dismiss(animated: true, completion: nil)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Deck.shared.sections.last!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let list = Deck.sortedCityList(section: Deck.shared.sections.last!)
        return list[row].cityName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let list = Deck.sortedCityList(section: Deck.shared.sections.last!)
        selectedCity = list[row]
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
