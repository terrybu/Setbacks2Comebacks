//
//  FavoritesViewController.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/24/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var favoritesArray = FavoritesData.sharedInstance.getFavoritesArrayFromDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "PersonTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoritesArray = FavoritesData.sharedInstance.getFavoritesArrayFromDefaults()
        tableView.reloadData()
        print(favoritesArray!.description)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PersonTableViewCell
        let person = favoritesArray![indexPath.row]
        cell.personFaceImageView.image = person.image
        cell.personNameLabel.text = person.name
        cell.personSetbacksTextView.text = person.setbacks.joined(separator: ", ")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

}
