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
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "SettingsNightModeDidUpdate"), object: nil, queue: OperationQueue.main) { (_) in
            self.updateBarColors()
        }
        
        updateBarColors()
    }
    
    override func viewDidLayoutSubviews() {
        tabBar.items![2].image = UIImage(named: "moreIcon")
        tabBarItem = tabBar.items![2] as UITabBarItem
        tabBarItem.title = "More"
    }
    
    private func updateBarColors() {
        if SettingsManager.shared.nightMode {
            self.tabBar.tintColor = UIColor.white
            self.tabBar.barTintColor = UIColor.black
        } else {
            self.tabBar.tintColor = UIColor.black
            self.tabBar.barTintColor = UIColor.white
        }

    }
}

