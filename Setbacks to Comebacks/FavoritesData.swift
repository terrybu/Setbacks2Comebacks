//
//  FavoritesData.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 3/20/17.
//  Copyright © 2017 Terry Bu. All rights reserved.
//

import Foundation

class FavoritesData {
    
    static let sharedFavoritesData = FavoritesData()
    let defaults = UserDefaults.standard
    private let FavoritesArrayKey = "favoritesArray"

    func addObjectToFavoritesAndSave(newPerson: Person) {
        var favArray = [Person]()
        if let array = defaults.array(forKey: FavoritesArrayKey) {
            favArray = array as! [Person]
        }
        favArray.append(newPerson)
        defaults.set(favArray, forKey: FavoritesArrayKey)
    }
    
    func getFavoritesArrayFromDefaults() -> [Person]? {
        if let array = defaults.array(forKey: FavoritesArrayKey) as? [Person] {
            return array
        }
        return nil
    }
    
    
}
