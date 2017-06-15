//
//  PeopleDataAccessObject.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/28/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import Foundation
import SwiftyJSON

class PeopleDataAccessObject {

    static let sharedObject = PeopleDataAccessObject()
    var peopleArray: [Person]?
    
    init() {
        peopleArray = getPeopleObjectsFromJSON()
    }
    
    private func getPeopleObjectsFromJSON() -> [Person]? {
        var peopleArray = [Person]()
        if let url = Bundle.main.url(forResource: "people", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let rootJSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                let swiftyJson = JSON(rootJSON)
                let peopleJSONArray = swiftyJson["people"].arrayValue
                for json in peopleJSONArray {
                    let name = json["name"].stringValue
                    let bio = json["bio"].stringValue
                    let setbacks = json["setbacks"].arrayValue.map( {$0.string!} )
                    let quotesArray = json["quotes"].arrayValue.map( {$0.string!} )
                    let newPerson = Person(name: name, bio: bio, setbacks:setbacks, quotes: quotesArray)
                    peopleArray.append(newPerson)
                }
            } catch {
                return nil
            }
        }
        return peopleArray.sorted(by: {$0.name < $1.name })
    }
    
    func findAllPeopleWithSetbackNamed(setback: String) -> [Person] {
        return peopleArray!.filter({ $0.setbacks.contains(setback)})
    }
    
}
