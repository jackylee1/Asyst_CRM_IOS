//
//  MenuViewController.swift
//  AKSwiftSlideMenu
//
//  Created by Ashish on 21/09/15.
//  Copyright (c) 2015 Kode. All rights reserved.
//

import UIKit
import Firebase
import MessageUI
import ContactsUI
import EventKit
import FBSDKLoginKit





protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,MFMailComposeViewControllerDelegate,CNContactPickerDelegate{
   
    @IBOutlet var tblMenuOptions : UITableView!
   
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    var sectionCheck:[Bool] = []
    var arrayMenuOptions = [Dictionary<String,String>]()
    
    var arraySubMenuOptions = [String:String]()
   
    var btnMenu : UIButton!
    
    var delegate : SlideMenuDelegate?
    var selected = -1
    
   // let yourDate = UserDefaults.standard.object(forKey: "time") as? Date
    
//    var eventStore: EKEventStore!
//    var reminders: [EKReminder]!
    
    
    
    
    
    let data=[["Last logout time stamp","Calender","Phone book","Download","Email"],["Bulk Licence Generation"],[" "],["Contact","Chat"]]
    let imageicon=["time","calender","phone Book","texrEdit","download","email"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuOptions.tableFooterView = UIView()
        
        tblMenuOptions.estimatedRowHeight = 40
        tblMenuOptions.rowHeight = UITableViewAutomaticDimension
        sectionCheck=[false,false,false,false,false]
        updateArrayMenuOptions()
        
        
        
//        UserDefaults.standard.set(Date(), forKey: "time")
        
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        //updateArrayMenuOptions()
        //self.navigationItem.hidesBackButton = true
    }
    
    
    
    
    
    func updateArrayMenuOptions(){
        
        arrayMenuOptions.append(["title":"Dashboard", "icon":"Dashboard-64"])
        arrayMenuOptions.append(["title":"Agent Login", "icon":"Administrator"])
        arrayMenuOptions.append(["title":"Bulk Assign", "icon":"Menu-64"])
        arrayMenuOptions.append(["title":"HelpLine", "icon":"WhatsApp-64"])
        arrayMenuOptions.append(["title":"About", "icon":"Organization-64"])
        arrayMenuOptions.append(["title":"Log out", "icon":"Logout-64"])
        
       // arraySubMenuOptions=["title":"Dashboard","title":"Users","title":"Bulk Licence Generation","title":"Product Log","title":"Agent Log"]
              
        
        tblMenuOptions.reloadData()
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        })
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sectionCheck[indexPath.section] {
            return 50
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell") as! MenuTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        
        if indexPath.section != 2{
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
        
        //let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
        //imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        
        lblTitle.text = data[indexPath.section][indexPath.row]
        }
        
        
        
        if indexPath.section == 0{
            //cell.separatorInset.right = 40.0
            
           
            let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
            let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
            //cell.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
            imgIcon.image = UIImage(named: imageicon[indexPath.row])
            lblTitle.text = data[indexPath.section][indexPath.row]
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        
        
        
        if data[indexPath.section][indexPath.row] == "Bulk Licence Generation"
        {
          // let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "BulkLicenceViewController") as! BulkLicenceViewController
            
            let storyBoard = UIStoryboard(name:"Main",bundle:nil)
            let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "BulkLicenceViewController") as! BulkLicenceViewController
            vcOBJ.title="Bulk Licence Generation"
            
            //vcOBJ.myViewController = "Bulk Licence Generation"
//           // self.presentedViewController?.show(vcOBJ, sender: true)
//            self.navigationController?.pushViewController(vcOBJ, animated: true)
            
            
            vcOBJ.myViewController = "Bulk Licence"
            self.navigationController?.pushViewController(vcOBJ, animated: true)

            
            
        }
        
        
        if data[indexPath.section][indexPath.row] == "Contact"
        {
            let storyBoard = UIStoryboard(name:"Main",bundle:nil)
            let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
            vcOBJ.title="Contact Us"
            //vcOBJ.myViewController = "Contact Us"
            //self.presentedViewController?.show(vcOBJ, sender: true)
            
            self.navigationController?.pushViewController(vcOBJ, animated: true)
        }
        
        if data[indexPath.section][indexPath.row] == "Last logout time stamp"
        {
          
          //  LastLoginDetailsTableViewController
            
            
            let storyBoard = UIStoryboard(name:"Main",bundle:nil)
            let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "LastLoginDetailsTableViewController") as! LastLoginDetailsTableViewController
            vcOBJ.title="Last 10 Login Logout Details"
            //vcOBJ.myViewController = "Contact Us"
            //self.presentedViewController?.show(vcOBJ, sender: true)
            
            self.navigationController?.pushViewController(vcOBJ, animated: true)
            
            
            
          // print("last log out time=\(String(describing: UserDefaults.standard.object(forKey: "time")))")
        }
        
        if data[indexPath.section][indexPath.row] == "Calender"
        {
         
            UIApplication.shared.openURL(NSURL(string: "calshow://")! as URL)
        }
        
        if data[indexPath.section][indexPath.row] == "Download"
        {
            
            UIApplication.shared.openURL(NSURL(string: "ms-excel://")! as URL)
        }
        
        
        if data[indexPath.section][indexPath.row] == "Email"
        {
            
            let storyBoard = UIStoryboard(name:"Main",bundle:nil)
            let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "EmailViewController") as! EmailViewController
            vcOBJ.title="Email"
            //vcOBJ.myViewController = "Contact Us"
            //self.presentedViewController?.show(vcOBJ, sender: true)
            
            self.navigationController?.pushViewController(vcOBJ, animated: true)
            
            
        }
        

        if data[indexPath.section][indexPath.row] == "Phone book"
        {
            self.call()
            
            
        }
        
        if data[indexPath.section][indexPath.row] == "Chat"
        {
            
            let usefullWhere: String = "whatsapp://?app" 
            let url = NSURL(string: usefullWhere)!
            UIApplication.shared.openURL(url as URL)
            
        }
        
        if data[indexPath.section][indexPath.row] == "TextEdit"
        {
//
//            var eventStore = EKEventStore()
//            
//            eventStore.requestAccess(to: EKEntityType.reminder, completion:
//                {(granted, error) in
//                    if !granted {
//                        print("Access to store not granted")
//                    }
//            })   
            
            
            //NSWorkspace.shared().open(URL(fileURLWithPath: "/Applications/Photos.app"))
            
            
            
        }
        
        
        
        self.onCloseMenuClick(btn)
    
    }
    
    
    
    
    func call()
    {
        
        
        let entityType = CNEntityType.contacts
        let authStatus = CNContactStore.authorizationStatus(for: entityType)
        
        if authStatus == CNAuthorizationStatus.notDetermined
        {
            let contactStore = CNContactStore.init()
            contactStore.requestAccess(for: entityType, completionHandler: {(sucess, nil) in
                
                if sucess {
                    self.openContacts()
                }
                else{
                    print("Not Authorized ")
                }
                
            })
            
        }
        else if authStatus == CNAuthorizationStatus.authorized{
            self.openContacts()
            
        }

        
        
    }
    
    func openContacts(){
        
        let contactPicker = CNContactPickerViewController.init()
        contactPicker.delegate = self
        self.navigationController?.present(contactPicker, animated: true, completion: nil)
        //self.present(contactPicker, animated: true, completion: nil)
        
    }
    
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true){
            
        }
    }
    
    func contactPicker(_picker: CNContactPickerViewController, didSelect contact: CNContact)
    {
        //print("kashee 12345")
        

        
    }
    
    
    
    
//    func mailToAgent(){
//        
//       let composer = MFMailComposeViewController()
//        
//        if MFMailComposeViewController.canSendMail() {
//            composer.mailComposeDelegate = self
//            composer.setToRecipients(["Email1", "Email2"])
//            composer.setSubject("Hello!")
//            composer.setMessageBody("Text Body", isHTML: false)
//            present(composer, animated: true, completion: nil)
//        }
//        
//        
//    }
//    
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        print("Hello world!")
//        dismiss(animated: true, completion: nil)
//    }
 
    
    
    
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 5
        }
        
        if section==1 {
            return 1
        }
        if section==2 {
            return 0
        }
        if section==3 {
            return 2
        }
        if section==4 {
            return 0
        }
        if section==5
        {
            return 0
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayMenuOptions.count;
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let frame: CGRect = tblMenuOptions.frame
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0,width: frame.size.width, height:50))
        let headerButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0,width: frame.size.width,height: 50))
        headerButton.setTitle(arrayMenuOptions[section]["title"], for: .normal)
        headerButton.setTitleColor(UIColor.black, for: .normal)
        headerButton.backgroundColor = UIColor.orange
         headerButton.contentHorizontalAlignment = .left
        
        
        
       // headerButton.titleEdgeInsets.left = -UIScreen.main.bounds.width+110
         headerButton.setImage(UIImage(named: arrayMenuOptions[section]["icon"]!), for: UIControlState.normal)
        // headerButton.setImage(UIImage(named: "drop_down"), for: UIControlState.selected)
        //headerButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 300, bottom: 0, right: 5)
        headerButton.imageView?.contentMode = .scaleAspectFit
        
        headerButton.tag = section
        headerButton.addTarget(self, action: #selector(MenuViewController.buttonTapped(sender:)), for: .touchUpInside)
        headerView.addSubview(headerButton)
        return headerView
    }
    

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }

    
    
    
    
    func buttonTapped(sender: UIButton) {
        
        if sender.tag == 0
        {
           sectionCheck[sender.tag] = !sectionCheck[sender.tag]
        }
        
        if sender.tag == 1
        {
            sectionCheck[sender.tag] = !sectionCheck[sender.tag]
        }
        
        if sender.tag == 2
        {
            sectionCheck[sender.tag] = !sectionCheck[sender.tag]
            
            let storyBoard = UIStoryboard(name:"Main",bundle:nil)
            let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "BulkLicenceViewController") as! BulkLicenceViewController
            vcOBJ.title="Bulk Assign"
            vcOBJ.myViewController = "Bulk Assign"
            //self.presentedViewController?.show(vcOBJ, sender: true)
            self.navigationController?.pushViewController(vcOBJ, animated: true)
            
            
        }
        if sender.tag == 3
        {
            sectionCheck[sender.tag] = !sectionCheck[sender.tag]
        }
        if sender.tag == 4
        {
            sectionCheck[sender.tag] = !sectionCheck[sender.tag]
            
//            if data[indexPath.section][indexPath.row] == "About"
//            {
                let storyBoard = UIStoryboard(name:"Main",bundle:nil)
                let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "About")
                vcOBJ.title="About"
                //vcOBJ.myViewController = "Contact Us"
                self.presentedViewController?.show(vcOBJ, sender: true)
                self.navigationController?.pushViewController(vcOBJ, animated: true)
            
//            }

            
            
        }
        if sender.tag == 5
        {
            let manager = FBSDKLoginManager()
            manager.logOut()
            
            try! Auth.auth().signOut()
            if let storyboard = self.storyboard {
                let storyBoard = UIStoryboard(name:"Main",bundle:nil)
                let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                
                self.presentedViewController?.show(vcOBJ, sender: true)
                //self.navigationItem.setHidesBackButton(true, animated: false)
                self.navigationController?.pushViewController(vcOBJ, animated: true)
            }
            
          //UserDefaults.standard.set(Date(), forKey: "time")
            
            let storyBoard1 = UIStoryboard(name:"Main",bundle:nil)
            let vcOBJ1 = storyBoard1.instantiateViewController(withIdentifier: "LastLoginDetailsTableViewController") as! LastLoginDetailsTableViewController
            //vcOBJ1.title="Bulk Licence Generation"
            
            var logoutData = vcOBJ1.logoutDetails.object(forKey: "logout") as? [String] ?? [String]()
            
            
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
            
            
//            logoutData.append(myStringafd)
            
            
            vcOBJ1.logoutDetails.set(logoutData, forKey: "logout")
            vcOBJ1.logoutDetails.synchronize()
            
         
        }
        
        print(sender.isSelected)
        selected = sender.tag
        tblMenuOptions.reloadData()
    }
    
   

    
    
}
