//
//  PersonDetailViewController.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 12/26/16.
//  Copyright © 2016 Terry Bu. All rights reserved.
//

import UIKit
import TagListView
import MessageUI

class PersonDetailViewController: BaseViewController, TagListViewDelegate, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate {

    var person: Person!
    @IBOutlet var personFaceImageView: UIImageView!
    @IBOutlet var personBioTextView: UITextView!
    @IBOutlet weak var favoritesStarBarButton: UIBarButtonItem!
    @IBOutlet var tagListView: TagListView!
    @IBOutlet var goToQuotesButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = person.name
        navigationItem.prompt = "Tap on person's image to shortcut to his quotes"
        
        personFaceImageView.image = person.image
        personBioTextView.text = person.bio
        checkForStarButtonNecessity()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "SettingsFontDidUpdate"), object: nil, queue: OperationQueue.main) { (_) in
            self.setFontToSavedSettings()
        }
        setFontToSavedSettings()
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
        
        goToQuotesButton.setTitle("See Quotes by \(person.name)", for: UIControlState.normal)
        goToQuotesButton.layer.cornerRadius = goToQuotesButton.frame.height/2
        goToQuotesButton.titleLabel?.lineBreakMode = .byWordWrapping
        goToQuotesButton.titleLabel?.textAlignment = .center
        
        personBioTextView.textContainerInset = UIEdgeInsets.zero
        personBioTextView.textContainer.lineFragmentPadding = 0
        personBioTextView.sizeToFit()
        personBioTextView.textContainer.size = personBioTextView.frame.size
        self.view.layoutIfNeeded()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PersonDetailViewController.longTap))
        personFaceImageView.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
    }
    
    func longTap(){
        performSegue(withIdentifier: "quotes", sender: nil)
    }
    
    override func viewWillLayoutSubviews() {
        if person.setbacks.isEmpty {
            personBioTextView.frame = CGRect(x: personFaceImageView.frame.origin.x, y: personFaceImageView.frame.size.height + 32, width: personBioTextView.frame.size.width, height: personBioTextView.frame.size.height)
        }
    }
    
    private func setFontToSavedSettings() {
        personBioTextView.font = UIFont(name: self.personBioTextView.font!.fontName, size: CGFloat(SettingsManager.shared.fontSize.size()))
        goToQuotesButton.titleLabel?.font = UIFont(name: goToQuotesButton.titleLabel!.font!.fontName, size: CGFloat(SettingsManager.shared.fontSize.size()))
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title)")
        let peopleArray = PeopleDataAccessObject.sharedObject.findAllPeopleWithSetbackNamed(setback: title)
        let peopleNames = peopleArray.map({$0.name})
        let alertMessageBody = peopleNames.joined(separator: ", ")
        let alertView = UIAlertController(title: "People who shared '\(title)' as setback", message: alertMessageBody, preferredStyle: UIAlertControllerStyle.alert)
        alertView.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alertView.dismiss(animated: true, completion: nil)
        }))
        alertView.addAction(UIAlertAction(title: "Share via text", style: .default, handler: { (action) in
            self.sendTextMessage(text: "People who shared '\(title)' as a setback include \(alertMessageBody)")
        }))
        self.present(alertView, animated: true)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quotes" {
            let qvc = segue.destination as! QuotesViewController
            qvc.person = person
        }
    }
    
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.setSubject("Sending you an inspiring setback to comeback story: \(person.name)")
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.addAttachmentData(UIImageJPEGRepresentation(UIImage(named: person.name)!, CGFloat(1.0))!, mimeType: "image/jpeg", fileName:  "\(person.name).jpeg")
        let emailHTMLBody = "<p>[This is an excerpt from an iOS App - Setbacks 2 Comebacks in the iTunes App Store]</p><br><br><h1>Inspiring comeback story:\(person.name)</h1> <p>\(person.bio)</p>"
        mailComposerVC.setMessageBody(emailHTMLBody, isHTML: true)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil
    }
    
}
