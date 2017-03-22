//
//  Person.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/24/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
    
    let name: String
    let bio: String
    let setbacks: [String]
    var image: UIImage
    var occupation: [String] = []
    var placeOfBirth: String = ""
    var dob: String = ""
    var alive: Bool = false
    
    init(name: String, bio: String, setbacks: [String]) {
        self.name = name
        self.bio = bio
        self.setbacks = setbacks.sorted(by: {$0 < $1})
        self.image = UIImage(named:"placeholderFace")!
        if let actualFaceImg = UIImage(named: name) {
            self.image = actualFaceImg
        } else {
            //this is to check for any accents in the image filename that prevented santiago cajal from registering
            let diacriticRemovedStr = name.folding(options: String.CompareOptions.diacriticInsensitive, locale: .current)
            if let actualFaceImg2 = UIImage(named: diacriticRemovedStr) {
                self.image = actualFaceImg2
            }
        }
    }
    
    //Also remember to conform your class to NSObject and NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(bio, forKey: "bio")
        aCoder.encode(setbacks, forKey: "setbacks")
    }
    
    convenience required init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let bio = aDecoder.decodeObject(forKey: "bio") as! String
        let setbacks = aDecoder.decodeObject(forKey: "setbacks") as! [String]
        self.init(name: name, bio: bio, setbacks: setbacks)
    }

    
    
}
