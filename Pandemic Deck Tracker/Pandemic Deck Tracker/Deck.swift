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
    var removed = [City: Int]()
    
    enum Section: Int {
        case Removed = -2,
        Discard = -1,
        Top = 0
    }
    
    var cityList: [City] {
        get {
            var cities: Set<City> = []
            for section in sections {
                for key in section.keys {
                    cities.insert(key)
                }
            }
            
            for key in discard.keys {
                cities.insert(key)
            }
            
            for key in removed.keys {
                cities.insert(key)
            }
            
            return cities.sorted()
        }
    }
    
    private static let startingCities = [
        "New York", "Washington", "Jacksonville", "Sao Paulo", "London", "Istanbul", "Tripoli", "Cairo", "Lagos"
    ]
    
    static let additionalCities = [
        "Buenos Aires" : 2, "Santiago" : 1, "Lima" : 1, "Bogota" : 2, "Baghdad" : 2, "Tehran" : 1, "Riyadh" : 2,
        "Delhi" : 1, "New Mumbai" : 2, "Kolkata" : 1, "Chicago" : 2, "Atlanta" : 1, "Mexico City" : 1, "Los Angeles" : 1,
        "San Francisco" : 2, "Denver" : 2, "Kinshasa" : 1, "Khartoum" : 1, "Dar es Salaam" : 2, "Johannesburg" : 2, "Antananarivo" : 2
    ]
    
    private init() {
        sections.append([City : Int]())
        
        if let data = UserDefaults.standard.data(forKey: "cities") {
            let cities = try? JSONDecoder().decode([City].self, from: data)
            for city in cities ?? [] {
                addCity(city: city)
            }
        } else {
            addStartingCities()
            //TODO: Remove once saving is implemented
            addAdditionalCities()
        }
        
        
    }
    
    func remove(card: City, from section: Int) {
        if section == Deck.Section.Removed.rawValue {
            guard let num = removed[card] else { return }
            
            if num > 1 {
                removed[card] = num - 1
            } else {
                removed[card] = nil
            }
        } else if section == Deck.Section.Discard.rawValue {
            guard let num = discard[card] else { return }
            
            if num > 1 {
                discard[card] = num - 1
            } else {
                discard[card] = nil
            }
        } else {
            guard let num = sections[section][card] else { return }
            
            if num > 1 {
                sections[section][card] = num - 1
            } else {
                sections[section][card] = nil
            }
        }
    }
    
    func add(card: City, to section: Int) {
        if section == Deck.Section.Removed.rawValue {
            if let num = removed[card] {
                removed[card] = num + 1
            } else {
                removed[card] = 1
            }
        } else if section == Deck.Section.Discard.rawValue {
            if let num = discard[card] {
                discard[card] = num + 1
            } else {
                discard[card] = 1
            }
        } else {
            if let num = sections[section][card] {
                sections[section][card] = num + 1
            } else {
                sections[section][card] = 1
            }
        }
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
    
    static func saveCities() {
        let encodedData = try? JSONEncoder().encode(shared.cityList)
        UserDefaults.standard.set(encodedData, forKey: "cities")
    }
    
    private func addCity(name: String, num: Int) {
        let newCity = City(name: name, cards: num)
        sections[0][newCity] = num
    }
    
    private func addCity(city: City) {
        sections[0][city] = city.numCards
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
