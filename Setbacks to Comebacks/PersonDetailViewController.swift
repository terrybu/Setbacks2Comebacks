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
        self.navigationController?.navigationBar.topItem?.title = ""
        
        personFaceImageView.image = person.image
        personBioTextView.text = person.bio
        checkForStarButtonNecessity()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "SettingsFontDidUpdate"), object: nil, queue: OperationQueue.main) { (_) in
            self.personBioTextView.font = UIFont(name: self.personBioTextView.font!.fontName, size: CGFloat(SettingsManager.shared.fontSize.size()))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Your Favorites"
    }

    
    private func checkForStarButtonNecessity() {
        if navigationController?.viewControllers[0] is FavoritesTableViewController  {
            navigationItem.rightBarButtonItem = nil
            return
        }
        
        let favArray = FavoritesData.sharedInstance.favoritesArray
        if favArray.contains(where: { $0.name == person.name }) {
            print("yes already in favorites")
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorited", style: UIBarButtonItemStyle.done, target: self, action: nil)
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
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
