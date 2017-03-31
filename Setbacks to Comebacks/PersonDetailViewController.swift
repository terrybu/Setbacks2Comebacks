//
//  PersonDetailViewController.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/26/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import UIKit
import TagListView

class PersonDetailViewController: UIViewController, TagListViewDelegate {

    var person: Person!
    
    @IBOutlet var personFaceImageView: UIImageView!
    @IBOutlet var personBioTextView: UITextView!
    @IBOutlet weak var favoritesStarBarButton: UIBarButtonItem!
    @IBOutlet var tagListView: TagListView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = person.name
        
        personFaceImageView.image = person.image
        personBioTextView.text = person.bio
        checkForStarButtonNecessity()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "SettingsFontDidUpdate"), object: nil, queue: OperationQueue.main) { (_) in
            self.personBioTextView.font = UIFont(name: self.personBioTextView.font!.fontName, size: CGFloat(SettingsManager.shared.fontSize.size()))
        }
        tagListView.delegate = self
        tagListView.cornerRadius = 12
        tagListView.paddingX = 10
        tagListView.paddingY = 10
        tagListView.tagBackgroundColor = UIColor.darkGray
        tagListView.textColor = UIColor.white
        tagListView.textFont = UIFont.boldSystemFont(ofSize: 14)
        for setback in person.setbacks {
            tagListView.addTag(setback)
        }
        
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
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
