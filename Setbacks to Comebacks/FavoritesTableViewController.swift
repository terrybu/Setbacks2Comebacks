//
//  FavoritesTableViewController.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/24/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var favoritesArray = FavoritesData.sharedInstance.getFavoritesArrayFromDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Favorites"
        
        tableView.register(UINib.init(nibName: "PersonTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "SettingsFontDidUpdate"), object: nil, queue: OperationQueue.main) { (_) in
            self.tableView!.reloadData()
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        favoritesArray = FavoritesData.sharedInstance.getFavoritesArrayFromDefaults()
        tableView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if !tableView.isEditing {
            tableView.setEditing(true, animated: true)
        } else { //if it IS editing
            tableView.setEditing(false, animated: true)
        }
    }
    
    
    //MARK: - UITableView Data Source Methods
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
        cell.personSetbacksLabel.text = person.setbacks.joined(separator: ", ")
        cell.personSetbacksLabel.font = UIFont(name: cell.personSetbacksLabel.font!.fontName, size: CGFloat(SettingsManager.shared.fontSize.size()))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.favoritesArray?.remove(at: indexPath.row)
            FavoritesData.sharedInstance.favoritesArray.remove(at: indexPath.row)
            FavoritesData.sharedInstance.saveFavoritesArrayCurrentStateIntoDefaults()
            self.tableView.reloadData()
        }
    }
    
    //MARK:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PersonDetailViewController") as! PersonDetailViewController
        detailVC.person = favoritesArray![indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
