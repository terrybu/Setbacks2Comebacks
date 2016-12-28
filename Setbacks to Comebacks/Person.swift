//
//  Person.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/24/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import Foundation

struct Person {
    
    let name: String
    let bio: String
    let setbacks: [String]
    var occupation: [String]?
    var placeOfBirth: String?
    var dob: Date?
    var alive: Bool = false
    
    init(name: String, bio: String, setbacks: [String]) {
        self.name = name
        self.bio = bio
        self.setbacks = setbacks
    }
    
}
