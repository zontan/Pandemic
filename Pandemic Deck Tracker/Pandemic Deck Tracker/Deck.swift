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
        
        City(name: "Atlanta", cards: 1),
        City(name: "Chicago", cards: 2),
        City(name: "Denver", cards: 2),
        City(name: "Los Angeles", cards: 1),
        City(name: "Mexico City", cards: 1),
        City(name: "San Francisco", cards: 2),
        
        City(name: "Bogota", cards: 2),
        City(name: "Buenos Aires", cards: 2),
        City(name: "Lima", cards: 1),
        City(name: "Santiago", cards: 1),
        
        City(name: "Antananarivo", cards: 2),
        City(name: "Dar es Salaam", cards: 2),
        City(name: "Johannesburg", cards: 2),
        City(name: "Khartoum", cards: 1),
        City(name: "Kinshasa", cards: 1),
        
        City(name: "Baghdad", cards: 2),
        City(name: "Delhi", cards: 1),
        City(name: "Kolkata", cards: 1),
        City(name: "New Mumbai", cards: 2),
        City(name: "Riyadh", cards: 2),
        City(name: "Tehran", cards: 1),
        
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
            //addAdditionalCities()
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
    
    func resetDeck() {
        for (city, num) in discard {
            for _ in 0..<num {
                remove(card: city, from: Deck.Section.Discard.rawValue)
                add(card: city, to: Deck.Section.Top.rawValue)
            }
        }
        
        for (city, num) in removed {
            for _ in 0..<num {
                remove(card: city, from: Deck.Section.Removed.rawValue)
                add(card: city, to: Deck.Section.Top.rawValue)
            }
        }
        
        if sections.count == 1 {
            return
        }
        
        for i in (1..<sections.count).reversed() {
            for (city, num) in sections[i] {
                for _ in 0..<num {
                    remove(card: city, from: i)
                    add(card: city, to: Deck.Section.Top.rawValue)
                }
            }
            sections.remove(at: i)
        }
    }
    
    static func sortedCityList(section: [City: Int]) -> [City] {
        return section.keys.sorted()
    }
    
    static func addCity(name: String) {
        let cityIndex = additionalCities.index { (city) -> Bool in
            city.cityName == name
        }
        if let index = cityIndex {
            shared.addCity(city: additionalCities[index])
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
        for city in Deck.additionalCities {
            addCity(city: city)
        }
    }
    
    private func addStartingCities() {
        for city in Deck.startingCities {
            addCity(name: city, num: 3)
        }
    }
}
