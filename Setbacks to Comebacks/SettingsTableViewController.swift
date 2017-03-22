//
//  SettingsTableViewController.swift
//  TaoTeChingSwift
//
//  Created by David Weissler on 10/16/16.
//  Copyright © 2016 Bogil, John. All rights reserved.
//

import UIKit
import MessageUI

enum SettingsCell : Int {
    case fontSize = 0, rateApp, feedback, count
    
    func label() -> String {
        switch self {
        case .fontSize: return "Set font size"
        case .rateApp: return "Rate this app"
        case .feedback: return "Feedback"
        case .count : return ""
        }
    }
}

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    //TODO: Must submit to app store first to get URL and THEN put the URL string here
    let APP_URL_STRING = ""
    var composeVC: MFMailComposeViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "More"
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "SettingsFontDidUpdate"), object: nil, queue: OperationQueue.main) { (_) in
            self.tableView!.reloadData()
            let selectedIndexPath = IndexPath(row: SettingsManager.shared.fontSize.rawValue, section: 0)
            self.tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
        }
        
        composeVC = MFMailComposeViewController()
        composeVC!.mailComposeDelegate = self
        composeVC!.setToRecipients(["jupiterouroboros@gmail.com"])
        composeVC!.setSubject("User Feedback from Setbacks 2 Comebacks!!")
        composeVC!.setMessageBody("Hi, My feedback for your app is ... ", isHTML: false)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsCell.count.rawValue
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        let cellType = SettingsCell(rawValue: indexPath.row)
        cell.textLabel!.text = cellType!.label()
        cell.textLabel!.font = UIFont(name: cell.textLabel!.font.fontName, size: CGFloat(SettingsManager.shared.fontSize.size()))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = SettingsCell(rawValue: indexPath.row)
        
        if cellType == .fontSize {
            let fontSize = UIStoryboard(name: "SettingsStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "FontSize")
            navigationController?.pushViewController(fontSize, animated: true)
        } else if cellType == .rateApp {
            if let path = URL(string: APP_URL_STRING) {
                UIApplication.shared.open(path) {
                    (didOpen:Bool) in
                    if !didOpen {
                        print("Error opening:\(path.absoluteString)")
                    }
                }
            }
        } else if cellType == .feedback {
            // Present the view controller modally.
            if !MFMailComposeViewController.canSendMail() {
                print("Mail services are not available")
                return
            } else {
                self.present(composeVC!, animated: true, completion: nil)
            }
        }
    }
}
