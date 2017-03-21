//
//  FavoritesData.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 3/20/17.
//  Copyright © 2017 Terry Bu. All rights reserved.
//

import Foundation

class FavoritesData {
    
    static let sharedInstance = FavoritesData()
    let defaults = UserDefaults.standard
    private let FavoritesArrayDataKey = "FavArrayData"

    func addObjectToFavoritesAndSave(newPerson: Person) {
        var favArray: [Person]
        if let data = defaults.data(forKey: FavoritesArrayDataKey) {
            let array = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Person]
            favArray = array
        } else {
            favArray = [Person]()
        }
        favArray.append(newPerson)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: favArray)
        defaults.set(data, forKey: FavoritesArrayDataKey)
        defaults.synchronize()
    }
    
    func getFavoritesArrayFromDefaults() -> [Person]? {
        if let data = defaults.data(forKey: FavoritesArrayDataKey) {
            let array = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Person]
            return array
        }
        return nil
    }
    
    
}
