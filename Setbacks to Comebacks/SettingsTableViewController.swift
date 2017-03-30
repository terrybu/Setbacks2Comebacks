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
    case fontSize = 0, aboutThisApp, rateApp, feedback, followDev, count
    
    func label() -> String {
        switch self {
        case .fontSize: return "Set Font Size"
        case .aboutThisApp: return "About This App"
        case .rateApp: return "Rate this App in App Store"
        case .feedback: return "Email Feedback to Developer"
        case .followDev: return "Follow Developer on Instagram"
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
        } else if cellType == .aboutThisApp {
            //TODO: Prompt an alertview with a brief blurb on what this app is about
            let aboutAppString = "Setbacks2Comebacks is an educational and motivational iOS app written in Swift. It lists inspiring historical figures who have turned their life obstacles and setbacks into comebacks and tests into testimonies. The writing is a mixture of both copied articles from the Internet and my own. This app was made as a compilation of autobiographies of both past greats and living greats who made significant impact on the world. My sources come from Wikipedia, Google, biography.com and the like. This app will never have advertisements and will always be free. I hope you enjoy it! Please feel free to send me feedback via email or follow me at @burownrice."
            let alertView = UIAlertController(title: "About This App", message: aboutAppString, preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                alertView.dismiss(animated: true, completion: nil)
            }))
            self.present(alertView, animated: true)
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
            composeVC = MFMailComposeViewController()
            if let vc = composeVC {
                vc.mailComposeDelegate = self
                vc.setToRecipients(["jupiterouroboros@gmail.com"])
                vc.setSubject("User Feedback from Setbacks 2 Comebacks!!")
                vc.setMessageBody("", isHTML: false)
                if !MFMailComposeViewController.canSendMail() {
                    print("Mail services are not available")
                    return
                } else {
                    self.present(composeVC!, animated: true, completion: nil)
                }
            }
        } else if cellType == .followDev {
            UIApplication.shared.open(NSURL(string: "http://instagram.com/burownrice")! as URL, options: [:], completionHandler: nil)
        }
    }
    
    //MARK: Mail MFMailComposeVC Functions
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
