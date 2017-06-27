//
//  LastLoginDetailsTableViewController.swift
//  ACRMA
//
//  Created by Apogee on 6/15/17.
//  Copyright © 2017 Kode. All rights reserved.
//

import UIKit

class LastLoginDetailsTableViewController: UITableViewController {
    
    //let lastlogin = ["Kashee 12","Prakash 10","Ajay 3"]
    
    var logoutDetails = UserDefaults.standard
    
    var logoutData = [String]()
    var loginData = [String]()
    
    var logoutData1 = [String]()
    var loginData1 = [String]()
    
    
    
        //UserDefaults.standard.object(forKey: "time") as? Date

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutData1 = logoutDetails.object(forKey: "logout") as? [String] ?? [String]()
        loginData1 = logoutDetails.object(forKey: "login") as? [String] ?? [String]()
        
        loginData = loginData1.reversed()
        logoutData = logoutData1.reversed()
        
        

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return loginData.count
        }
        if section == 1{
            return logoutData.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LastLoginTableViewCell
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if indexPath.section == 0 {

            cell.label.text = loginData[indexPath.row]
        }
        
        if indexPath.section == 1{

            cell.label.text = logoutData[indexPath.row]
        }
        
              return cell
    }
 

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Last Login Date and Timing"
        }
        if section == 1{
            return "Last LogOut Date and Timing"
        }
        return ""
    }
   
}
