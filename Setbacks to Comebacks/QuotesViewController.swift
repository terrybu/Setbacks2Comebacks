//
//  QuotesViewController.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 5/20/17.
//  Copyright © 2017 Terry Bu. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

}
