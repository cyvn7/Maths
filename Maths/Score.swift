//
//  Score.swift
//  Maths
//
//  Created by Maciej Przybylski on 15/08/2019.
//  Copyright © 2019 Maciej Przybylski. All rights reserved.
//

//test

import UIKit
import WebKit
import MessageUI
class Score: UIViewController, MFMailComposeViewControllerDelegate {
    let upperClass = ActualGame()
    @IBOutlet weak var webView: WKWebView!
    var textFile = String()
    override func viewDidLoad() {
        var scoreViewFile = "<font size='+8' font face='helvetica'"
        if traitCollection.userInterfaceStyle == .dark {
             scoreViewFile += "font color='white'> <body style='background-color:black;'>" + textFile
        }
        else {
             scoreViewFile += "font color='black'> <body style='background-color:white;'>" + textFile
        }
        
        super.viewDidLoad()
        webView.loadHTMLString(scoreViewFile, baseURL: nil)
        upperClass.timer.invalidate()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendEmail(_ sender: UIBarButtonItem) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Wyniki gry")
            mail.setToRecipients(["dev.m.przybylski@gmail.com"])
            mail.setMessageBody(textFile, isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
