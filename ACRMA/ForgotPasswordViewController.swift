//
//  ForgotPasswordViewController.swift
//  ACRMA
//
//  Created by Apogee on 6/2/17.
//  Copyright © 2017 Kode. All rights reserved.
//

import UIKit
import Firebase
import Toaster

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailId: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ForgotPasswordViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    
    @IBAction func sendButton(_ sender: Any) {
        
        
        if isValidEmail(testStr: emailId.text!){
        
                Auth.auth().sendPasswordReset(withEmail: emailId.text!) { error in
                    if  error != nil {
                        // Display error message
                        if let errorCode = AuthErrorCode(rawValue: (error?._code)!) {
                            switch (errorCode) {
                            case .invalidEmail:
                                let alertController = UIAlertController(title: "Error", message: "Invalid email id", preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alertController.addAction(defaultAction)
                                self.present(alertController, animated: true, completion: nil)
                                return
        
                            default:
                                let alertController = UIAlertController(title: "Error", message: "This email id is not found", preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alertController.addAction(defaultAction)
                                self.present(alertController, animated: true, completion: nil)
                                return
                            }
                        }
        
                    } else {
                        Toast(text: "Please reset the password by clicking on link sent to your email").show()
                        self.emailId.text = ""
                    }}
        

        }else{
        
        let alertController = UIAlertController(title: "Error", message: "Please enter the valid email id or password", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
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
