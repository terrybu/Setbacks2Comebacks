//
//  BaseViewController.swift
//  Setbacks to Comebacks
//
//  Created by Terry Bu on 9/4/17.
//  Copyright © 2017 Terry Bu. All rights reserved.
//

import UIKit
import MessageUI

class BaseViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func sendTextMessage(text: String) {
        if (MFMessageComposeViewController.canSendText()) {
            let messageComposeVC = MFMessageComposeViewController()
            messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
            messageComposeVC.body = text
            self.present(messageComposeVC, animated: true, completion: nil)
        } else {
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }

}
