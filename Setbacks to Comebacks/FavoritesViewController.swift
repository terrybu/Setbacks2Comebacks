//
//  FavoritesViewController.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/24/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let favoritesArray = FavoritesData.sharedFavoritesData.getFavoritesArrayFromDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if favoritesArray == nil {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableViewCell
        let person = favoritesArray![indexPath.row]
        cell.personFaceImageView.image = person.image
        cell.personNameLabel.text = person.name
        cell.personSetbacksTextView.text = person.setbacks.joined(separator: ", ")
        return cell
    }

}
