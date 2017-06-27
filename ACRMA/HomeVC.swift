//
//  HomeVC.swift
//  AKSwiftSlideMenu
//
//  Created by MAC-186 on 4/8/16.
//  Copyright © 2016 Kode. All rights reserved.
//

import UIKit
import Firebase
import Toaster
import CoreData

class HomeVC: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
     //var logoutDetails = UserDefaults.standard
        
        // Do any additional setup after loading the view.
        
       // let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //let context = AppDelegate.
        
        
        
        
        let storyBoard1 = UIStoryboard(name:"Main",bundle:nil)
        let vcOBJ1 = storyBoard1.instantiateViewController(withIdentifier: "LastLoginDetailsTableViewController") as! LastLoginDetailsTableViewController
        //vcOBJ1.title="Bulk Licence Generation"
        
        var logoutData = vcOBJ1.logoutDetails.object(forKey: "login") as? [String] ?? [String]()
        
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date())
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        if logoutData.count == 10{
            
            for i in 0 ..< 10-1 {
                    logoutData[i]=logoutData[i+1]
            }
            logoutData[9] = myStringafd
        }else if logoutData.count < 10{
        
            logoutData.append(myStringafd)
        }
        
        
        vcOBJ1.logoutDetails.set(logoutData, forKey: "login")
        vcOBJ1.logoutDetails.synchronize()

        
        
        
        
        
        
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationItem.hidesBackButton = true
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
