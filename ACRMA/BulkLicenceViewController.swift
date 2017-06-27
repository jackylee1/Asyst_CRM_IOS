//
//  BulkLicenceViewController.swift
//  ACRMA
//
//  Created by Apogee on 6/5/17.
//  Copyright © 2017 Kode. All rights reserved.
//

import UIKit

class BulkLicenceViewController: UIViewController,UIWebViewDelegate {
    
    
    @IBOutlet weak var bulkLicenceWebPage: UIWebView!
    
    var boxView:UIView?
    
    
    var myViewController: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bulkLicenceWebPage.isOpaque = false
        bulkLicenceWebPage.backgroundColor = UIColor.clear
        
        bulkLicenceWebPage.delegate=self
        
       

        // Do any additional setup after loading the view.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        // Box config:
        boxView = UIView(frame: CGRect(x: 115, y: 110, width: 80, height: 80))
        boxView?.backgroundColor = UIColor.black
        boxView?.alpha = 0.9
        boxView?.layer.cornerRadius = 10
        
        // Spin config:
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityView.frame = CGRect(x: 20, y: 12, width: 40, height: 40)
        activityView.startAnimating()
        
        // Text config:
        let textLabel = UILabel(frame: CGRect(x: 0, y: 50, width: 80, height: 30))
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: textLabel.font.fontName, size: 13)
        textLabel.text = "Loading..."
        
        // Activate:
        boxView?.center = CGPoint(x: bulkLicenceWebPage.bounds.size.width/2, y: bulkLicenceWebPage.bounds.size.height/2)
        boxView?.addSubview(activityView)
        boxView?.addSubview(textLabel)
        view.addSubview(boxView!)
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
       // activityIndicator.stopAnimating()
        boxView?.removeFromSuperview()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        bulkLicenceWebPage.goBack()
    }
    
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        
        bulkLicenceWebPage.goForward()
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if myViewController == "Bulk Licence"
        {
            let url = URL(string: "http://usa.asystguard.com/crmlogin")
            bulkLicenceWebPage.loadRequest(URLRequest(url: url!))
        }
        if myViewController == "Bulk Assign"
        {
            let url = URL(string: "http://usa.asystguard.com:81/excel/")
            bulkLicenceWebPage.loadRequest(URLRequest(url: url!))
        }
        
        
    }

}
