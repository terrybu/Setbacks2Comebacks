//
//  PeopleDataAccessObject.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/28/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import Foundation

class PeopleDataAccessObject {
    //Singleton baby
    static let sharedObject = PeopleDataAccessObject()
    
    var peopleArray: [Person] = []
    
    init() {
        peopleArray = PeopleDataAccessObject.getPeopleObjectsFromJSON()
    }
    
    static func getPeopleObjectsFromJSON() -> [Person] {
        var peopleArray = [Person]()
        
        if let url = Bundle.main.url(forResource: "people", withExtension: "json") {
            //return peopleArray
           
        }
        
        let newton = Person(name: "Isaac Newton", bio: "test" ,setbacks: ["Bipolar", "Depression"])
        let jesus = Person(name: "Jesus Christ", bio: "test", setbacks: ["Suicidal Thoughts", "Betrayal", "Persecution"])
        let robinWilliams = Person(name: "Robin Williams", bio: "test", setbacks: ["Depression"])
        peopleArray = [newton, jesus, robinWilliams]
        
        return peopleArray
    }
    
}
