//
//  FontSizeTableViewController.swift
//  TaoTeChingSwift
//
//  Created by David Weissler on 10/30/16.
//  Copyright © 2016 Bogil, John. All rights reserved.
//

import UIKit

class FontSizeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Font Size"
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "SettingsFontDidUpdate"), object: nil, queue: OperationQueue.main) { (_) in
            self.tableView!.reloadData()
            let selectedIndexPath = IndexPath(row: SettingsManager.shared.fontSize.rawValue, section: 0)
            self.tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let selectedIndexPath = IndexPath(row: SettingsManager.shared.fontSize.rawValue, section: 0)
        tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FontSize.count.rawValue
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fontSizeCell", for: indexPath) as! FontSizeTableViewCell
        let fontSize = FontSize(rawValue: indexPath.row)
        
        cell.titleLabel.text = fontSize!.label()
        cell.titleLabel.font = UIFont(name: cell.titleLabel.font.fontName, size: CGFloat(SettingsManager.shared.fontSize.size()))
        
        cell.exampleLabel.text = "Example text"
        cell.exampleLabel.font = UIFont(name: cell.exampleLabel.font.fontName, size: CGFloat(fontSize!.size()))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fontSize = FontSize(rawValue: indexPath.row)
        SettingsManager.shared.updateFontSize(fontSize: fontSize!)
    }
}
