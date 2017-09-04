//
//  HomeTableViewController.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/24/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseViewController, UITableViewDelegate {
    
    var peopleArray: [Person]?
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "PersonTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "SettingsFontDidUpdate"), object: nil, queue: OperationQueue.main) { (_) in
            self.tableView!.reloadData()
        }
        
        peopleArray = PeopleDataAccessObject.sharedObject.peopleArray
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailPushSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PersonDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow
        {
            destination.person = peopleArray?[indexPath.row]
        }
    }
  
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        let segControl = sender as! UISegmentedControl
        peopleArray = PeopleDataAccessObject.sharedObject.peopleArray

        if segControl.selectedSegmentIndex == 1 {
            //past dead
            peopleArray = peopleArray?.filter({ (person) -> Bool in
                person.alive == false
            })
        } else if segControl.selectedSegmentIndex == 2 {
            //present alive
            peopleArray = peopleArray?.filter({ (person) -> Bool in
                person.alive == true
            })
        }
        tableView.reloadData()
    }
    
}

extension HomeTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PersonTableViewCell
        let person = peopleArray?[indexPath.row]
        cell.personFaceImageView.image = person?.image
        cell.personNameLabel.text = person?.name
        cell.personSetbacksLabel.text = person?.setbacks.joined(separator: ", ")
        cell.personSetbacksLabel.font = UIFont(name: cell.personSetbacksLabel.font!.fontName, size: CGFloat(SettingsManager.shared.fontSize.size()))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

}
