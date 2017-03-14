//
//  Person.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/24/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import UIKit

struct Person {
    
    let name: String
    let bio: String
    let setbacks: [String]
    var occupation: [String]?
    var placeOfBirth: String?
    var dob: Date?
    var alive: Bool = false
    var image: UIImage
    
    init(name: String, bio: String, setbacks: [String]) {
        self.name = name
        self.bio = bio
        self.setbacks = setbacks
        self.image = UIImage(named:"placeholderFace")!
        if let image = UIImage(named: name) {
            self.image = image
        } else {
            let diacriticRemovedStr = name.folding(options: String.CompareOptions.diacriticInsensitive, locale: .current)
            if let image2 = UIImage(named: diacriticRemovedStr) {
                self.image = image2
            }
        }
    }
    
}
