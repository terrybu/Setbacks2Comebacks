//
//  QuotesViewController.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 5/20/17.
//  Copyright © 2017 Terry Bu. All rights reserved.
//

import UIKit
import Social

class QuotesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.prompt = "Tap on quote to share via Facebook or Twitter"
        
        title = "Quotes by \(person!.name)"
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "SettingsFontDidUpdate"), object: nil, queue: OperationQueue.main) { (_) in
            self.collectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let quotes = person!.quotes {
            return quotes.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! QuotesCollectionViewCell
        cell.quoteLabel.text = person!.quotes![indexPath.row]
        cell.quoteLabel.font = UIFont(name: cell.quoteLabel.font!.fontName, size: CGFloat(SettingsManager.shared.fontSize.size()))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let quoteText = person!.quotes![indexPath.row]
        print("'\(quoteText)' - \(person.name)")
        let shareText = "'\(quoteText)' - \(person.name)"
        let actionController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let facebookAction = UIAlertAction(title: "Share via Facebook", style: .default) { (action) in
            let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            vc?.setInitialText(shareText)
            self.present(vc!, animated: true, completion: nil)
        }
        let twitterAction = UIAlertAction(title: "Share via Twitter", style: .default) { (action) in
            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            vc?.setInitialText(shareText)
            self.present(vc!, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionController.addAction(facebookAction)
        actionController.addAction(twitterAction)
        actionController.addAction(cancelAction)
        self.present(actionController, animated: true, completion: nil)
    }

}
