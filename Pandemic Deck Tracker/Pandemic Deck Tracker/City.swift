//
//  City.swift
//  Pandemic Deck Tracker
//
//  Created by Zontan on 12/24/17.
//  Copyright © 2017 Zontan. All rights reserved.
//

import Foundation

class City: Hashable, Comparable {
    var cityName: String
    var numCards: Int
    var supplyCubes: Int
    
    var hashValue: Int {
        get {
            return cityName.hashValue
        }
    }
    
    init(name: String, cards: Int) {
        cityName = name
        numCards = cards
        supplyCubes = 0
    }
    
    static func < (lhs: City, rhs: City) -> Bool {
        return lhs.cityName < rhs.cityName
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.cityName == rhs.cityName
    }
}
