//
//  PersonDetailViewController.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/26/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {

    var person: Person!
    
    @IBOutlet var personFaceImageView: UIImageView!
    @IBOutlet var personBioTextView: UITextView!
    @IBOutlet weak var favoritesStarBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = person.name
        personFaceImageView.image = person.image
        personBioTextView.text = person.bio
        
    }
    
    override func viewDidLayoutSubviews() {
        personBioTextView.setContentOffset(CGPoint(x:0, y:0), animated: false)
        personBioTextView.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    @IBAction func favoritsStarButtonPressed(sender: UIButton) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorited", style: UIBarButtonItemStyle.done, target: self, action: nil)
        FavoritesData.sharedInstance.addObjectToFavoritesAndSave(newPerson: person)
    }
    
    
    
}
