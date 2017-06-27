//
//  RegistrationViewController.swift
//  ACRMA
//
//  Created by Apogee on 6/2/17.
//  Copyright © 2017 Kode. All rights reserved.
//

import UIKit
import Firebase
import Toaster

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirompass: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegistrationViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        

        // Do any additional setup after loading the view.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }


    @IBAction func submitButton(_ sender: Any) {
        
        //let check = isValidEmail(testStr: emailId.text!)
        
        if isValidEmail(testStr: emailId.text!) && (password.text?.characters.count)! > 0 {
        
        if password.text! != confirompass.text! {
            let alertController = UIAlertController(title: "Error", message: "confirm password is not same as password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }else{
        
                Auth.auth().createUser(withEmail: emailId.text!, password: password.text!) { (user, error) in
        
                    if error == nil {
                        Toast(text: "You have sucessfully created your account").show()
                        self.emailId.text = ""
                        self.password.text = ""
                        self.confirompass.text = ""
                        
        
                    }else{
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }
        
        
        }
            
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
