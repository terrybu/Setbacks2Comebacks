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
//
//    var occupation: [String] = []
//    var placeOfBirth: String = ""
//    var dob: String = ""
//    var alive: Bool = false
    
    init(name: String, bio: String, setbacks: [String], image: UIImage) {
        self.name = name
        self.bio = bio
        self.setbacks = setbacks
        self.image = UIImage(named:"placeholderFace")!
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(bio, forKey: "bio")
        aCoder.encode(setbacks, forKey: "setbacks")
        let imageRepresentation = UIImagePNGRepresentation(image)
        aCoder.encode(imageRepresentation, forKey: "image")
    }
    
    convenience required init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let bio = aDecoder.decodeObject(forKey: "bio") as! String
        let setbacks = aDecoder.decodeObject(forKey: "setbacks") as! [String]
        let imageData = aDecoder.decodeObject(forKey: "image") as! Data
        let image = UIImage(data: imageData)!
        self.init(name: name, bio: bio, setbacks: setbacks, image: image)
    }

    
    
}
