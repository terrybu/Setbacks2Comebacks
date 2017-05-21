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
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! QuotesCollectionViewCell
        cell.quoteLabel.text = "TEST TERRY"
        return cell
    }

}
