//
//  Deck.swift
//  Pandemic Deck Tracker
//
//  Created by Zontan on 12/24/17.
//  Copyright © 2017 Zontan. All rights reserved.
//

import Foundation

class Deck {
    static var shared: Deck = Deck()
    
    var sections: [[City: Int]] = []
    var discard = [City: Int]()
    
    private static let startingCities = [
        "New York", "Washington", "Jacksonville", "Sao Paulo", "London", "Istanbul", "Tripoli", "Cairo", "Lagos"
    ]
    
    private static let additionalCities = [
        "Buenos Aires" : 2, "Santiago" : 1, "Lima" : 1, "Bogota" : 2, "Baghdad" : 2, "Tehran" : 1, "Riyhad" : 2,
        "Delhi" : 1, "New Mumbai" : 2, "Kolkata" : 1, "Chicago" : 2, "Atlanta" : 1, "Mexico City" : 1, "Los Angeles" : 1,
        "San Francisco" : 2, "Denver" : 2
    ]
    
    private init() {
        sections.append([City : Int]())
        addStartingCities()
        //TODO: Remove once saving is implemented
        addAdditionalCities()
    }
    
    static func sortedCityList(section: [City: Int]) -> [City] {
        return section.keys.sorted()
    }
    
    static func addCity(name: String) {
        let cityNum = additionalCities[name]
        if let num = cityNum {
            shared.addCity(name: name, num: num)
        } else if startingCities.contains(name) {
            shared.addCity(name: name, num: 3)
        } else {
            //TODO: Display error, invalid city name
            print("Error: Invalid city")
        }
    }
    
    private func addCity(name: String, num: Int) {
        let newCity = City(name: name, cards: num)
        sections[0][newCity] = num
    }
    
    private func addAdditionalCities() {
        for (key, value) in Deck.additionalCities {
            addCity(name: key, num: value)
        }
    }
    
    private func addStartingCities() {
        for city in Deck.startingCities {
            addCity(name: city, num: 3)
        }
    }
}
