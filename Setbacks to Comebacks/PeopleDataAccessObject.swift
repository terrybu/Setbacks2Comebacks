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
        let newton = Person(name: "Isaac Newton", setbacks: ["Bipolar", "Depression"])
        let jesus = Person(name: "Jesus Christ", setbacks: ["Suicidal Thoughts", "Betrayal", "Persecution"])
        let robinWilliams = Person(name: "Robin Williams", setbacks: ["Depression"])
        peopleArray = [newton, jesus, robinWilliams]
    }
    
}
