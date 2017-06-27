//
//  LoginViewController.swift
//  ACRMA
//
//  Created by Apogee on 6/2/17.
//  Copyright © 2017 Kode. All rights reserved.
//

import UIKit
import Firebase
import Toaster
import FBSDKLoginKit
import TwitterKit
import GoogleSignIn

class LoginViewController: UIViewController,FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
   //  var fbLoginSuccess = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setupFacebookButtons()
        setupTwitterButton()
        
       // fbLoginSuccess = true
        
        
    }
    
    
    
    
    
    fileprivate func setupTwitterButton() {
        
        let twitterButton = TWTRLogInButton { (session, error) in
            if let err = error {
                print("Failed to login via Twitter: ", err)
                return
            }
            
            
            guard let token = session?.authToken else { return }
            guard let secret = session?.authTokenSecret else { return }
            let credentials = TwitterAuthProvider.credential(withToken: token, secret: secret)
            
            Auth.auth().signIn(with: credentials, completion: { (user, error) in
                
                if let err = error {
                    print("Failed to login to Firebase with Twitter: ", err)
                    
                    let storyBoard = UIStoryboard(name:"Main",bundle:nil)
                    let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.presentedViewController?.show(vcOBJ, sender: true)
                    self.navigationController?.pushViewController(vcOBJ, animated: true)
                    
                    return
                }
                
                print("Successfully created a Firebase-Twitter user: ", user?.uid ?? "")
                //self.scrollView.isHidden = false
                
                
                Toast(text: "You have successfully logged in").show()
                let storyBoard = UIStoryboard(name:"Main",bundle:nil)
                let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "Organization") as! HomeVC
                self.presentedViewController?.show(vcOBJ, sender: true)
                self.navigationController?.pushViewController(vcOBJ, animated: true)
                
                
            })
            
            
        }
        
        scrollView.addSubview(twitterButton)
        twitterButton.frame = CGRect(x: 16, y: 320, width: view.frame.width - 32, height: 44)
    }
    
    
    
    
    fileprivate func setupFacebookButtons() {
        
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["email","public_profile"]
        loginButton.frame = CGRect(x: 16,y: 270,width: view.frame.width-32,height:44)
        scrollView.addSubview(loginButton)
        loginButton.delegate = self

    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did Log Out of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil
        {
            print(error)
            return
        }
        
//        
        if let userToken = result.token{
            print("Token=\(FBSDKAccessToken.current())")
        
//        print("Sucessfully loged in with Facebook")
        Toast(text: "You have successfully logged in").show()
        let storyBoard = UIStoryboard(name:"Main",bundle:nil)
        let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "Organization") as! HomeVC
        self.presentedViewController?.show(vcOBJ, sender: true)
        self.navigationController?.pushViewController(vcOBJ, animated: true)
//
//            Toast(text: "You have successfully logged in").show()
//            let presentPage = self.storyboard?.instantiateViewController(withIdentifier: "Organization") as! HomeVC
//                        let presentPageNav = UINavigationController(rootViewController: presentPage)
//            
//                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                        appDelegate.window?.rootViewController = presentPageNav
//            
            
           // fbLoginSuccess = true
        
        }
        
        
        
        
        
        
        
        self.showEmailAddress()
        
    }

    
    func showEmailAddress()
    {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else {
            return
        }
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials, completion: { (user, error) in
            
            if error != nil {
               
                print("some thing went wrong with our FB user ",error ?? "")
                return
                
            } else {
                
                print("Successfully Log in with our user ",user ?? "")
                
            }
        }
        )
     
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields" : "id, name, email"])
            .start(completionHandler:  { (connection, result, error) in
                
                if error != nil
                {
                    print("Fails to start graph request ",error ?? "" )
                    return
                }
                else{
                    print(result ?? "")
                    
                }
                
            })

    }
    
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        if (FBSDKAccessToken.current() != nil && fbLoginSuccess == true)
//        {
//            //performSegue(withIdentifier: "loginSegue", sender: self)
//            
//            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "Organization") as! HomeVC
//                                let homeVCNav = UINavigationController(rootViewController: homeVC)
//                                //homeVCNav.navigationBar.barTintColor = .red
//                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                                appDelegate.window?.rootViewController = homeVCNav
//            
//            
//        }
//        
//        fbLoginSuccess = true
//        
//        
//    }

    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        
        if FBSDKAccessToken.current() != nil{
            
//            
//                    let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "Organization") as! HomeVC
//                    let homeVCNav = UINavigationController(rootViewController: homeVC)
//                    homeVCNav.navigationBar.barTintColor = .red
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    appDelegate.window?.rootViewController = homeVCNav
            
            
            let storyBoard = UIStoryboard(name:"Main",bundle:nil)
            let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "Organization") as! HomeVC
            self.presentedViewController?.show(vcOBJ, sender: true)
            self.navigationController?.pushViewController(vcOBJ, animated: true)

            
        }
        
    
    }
    
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
  
   
    
    @IBAction func createAccount(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name:"Main",bundle:nil)
        let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        self.presentedViewController?.show(vcOBJ, sender: true)
        self.navigationController?.pushViewController(vcOBJ, animated: true)
        
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
            
            
            if (emailId.text?.characters.count)! > 0 && (password.text?.characters.count)! > 0{
    
            Auth.auth().signIn(withEmail: emailId.text!, password: password.text!) { (user, error) in
    
                if error == nil {
                    Toast(text: "You have successfully logged in").show()
                    let storyBoard = UIStoryboard(name:"Main",bundle:nil)
                    let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "Organization") as! HomeVC
                    self.presentedViewController?.show(vcOBJ, sender: true)
//                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.pushViewController(vcOBJ, animated: true)
                    
                                       
                    
 
                } else {
    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
                
            }else{
            
            let alertController = UIAlertController(title: "Error", message: "Please don't enter null value", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            }
        
        
        }
    
    
   
    @IBAction func forgotPassword(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name:"Main",bundle:nil)
        let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.presentedViewController?.show(vcOBJ, sender: true)
        self.navigationController?.pushViewController(vcOBJ, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
   
}
