//
//  QuotesViewController.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 5/20/17.
//  Copyright © 2017 Terry Bu. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController {
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quotes by \(person!.name)"
    }

}
