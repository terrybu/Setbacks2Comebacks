//
//  TabBarViewController.swift
//  TaoTeChingSwift
//
//  Created by John Bogil on 10/22/16.
//  Copyright © 2016 Bogil, John. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        tabBar.items![2].image = UIImage(named: "moreIcon")
        tabBarItem = tabBar.items![2] as UITabBarItem
        tabBarItem.title = "More"
//        tabBar.tintColor = UIColor.black
//        tabBar.barTintColor = UIColor.white
    }

}

