//
//  EmailViewController.swift
//  ACRMA
//
//  Created by Apogee on 6/9/17.
//  Copyright © 2017 Kode. All rights reserved.
//

import UIKit
import MessageUI
import Toaster

class EmailViewController: UIViewController,MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
            let composer = MFMailComposeViewController()
            
            if MFMailComposeViewController.canSendMail() {
                composer.mailComposeDelegate = self
                composer.setToRecipients(["Email1", "Email2"])
                composer.setSubject("Hello!")
                composer.setMessageBody("Text Body", isHTML: false)
                present(composer, animated: true, completion: nil)
            }
    
//        self.navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        print("Hello world!")
        dismiss(animated: true, completion: nil)
        
        Toast(text: "Mail Successfully sent").show()
        let storyBoard = UIStoryboard(name:"Main",bundle:nil)
        let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "Organization") as! HomeVC
        vcOBJ.title="ASYSTCRM"
        //vcOBJ.myViewController = "Contact Us"
        //self.presentedViewController?.show(vcOBJ, sender: true)
//
       self.navigationController?.pushViewController(vcOBJ, animated: true)

        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
