//
//  HomeTableViewController.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/24/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import UIKit

class HomeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var peopleArray: [Person]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleArray = [Person]()
        let newton = Person(name: "Isaac Newton", setbacks: ["Bipolar", "Depression"])
        let jesus = Person(name: "Jesus Christ", setbacks: ["Suicidal Thoughts", "Betrayal", "Persecution"])
        let robinWilliams = Person(name: "Robin Williams", setbacks: ["Depression"])
        peopleArray = [newton, jesus, robinWilliams]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        let person = peopleArray[indexPath.row]
        cell.textLabel?.text = person.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = peopleArray[indexPath.row]
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
