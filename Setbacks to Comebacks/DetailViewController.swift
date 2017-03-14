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
    
    @IBOutlet var personFaceImageView: UIImageView!
    @IBOutlet var personNameLabel: UILabel!
    @IBOutlet var personBioTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = person.name
        personFaceImageView.image = person.image
        personNameLabel.text = person.name
        personBioTextView.text = person.bio
        
        let favoritesNavItem = UIBarButtonItem(image: UIImage(named:"star_24"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailViewController.starPressed))
        navigationItem.rightBarButtonItem = favoritesNavItem
    }
    
    override func viewDidLayoutSubviews() {
        personBioTextView.setContentOffset(CGPoint(x:0, y:0), animated: false)
        personBioTextView.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    func starPressed() {
        print("sup")
    }

}
