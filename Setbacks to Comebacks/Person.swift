//
//  Person.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/24/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import Foundation

class Person {
    
    var name: String
    var dob: Date?
    var biography: String?
    var occupation: [String]?
    var setbacks: [String]
    var placeOfBirth: String?
    var alive: Bool = false
    
    init(name: String, setbacks: [String]) {
        self.name = name
        self.setbacks = setbacks
    }
    
}
