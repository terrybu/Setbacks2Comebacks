//
//  DetailViewController.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/26/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(person.name)
        title = person.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

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
