//
//  ContactUsViewController.swift
//  ACRMA
//
//  Created by Apogee on 6/6/17.
//  Copyright © 2017 Kode. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController,UIWebViewDelegate{
    
    @IBOutlet weak var contactWebView: UIWebView!
   
    @IBOutlet weak var contactActivity: UIActivityIndicatorView!
    
    
    var boxView:UIView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        contactWebView.isOpaque = false
        contactWebView.backgroundColor = UIColor.clear
        
        contactWebView.delegate = self
        contactActivity.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        
        contactActivity.startAnimating()
        contactActivity.hidesWhenStopped = true
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    
//    func webViewDidStartLoad(_ webView: UIWebView) {
//        // Box config:
//        boxView = UIView(frame: CGRect(x: 115, y: 110, width: 80, height: 80))
//        boxView?.backgroundColor = UIColor.black
//        boxView?.alpha = 0.9
//        boxView?.layer.cornerRadius = 10
//        
//        // Spin config:
//        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
//        activityView.frame = CGRect(x: 20, y: 12, width: 40, height: 40)
//        activityView.startAnimating()
//        
//        // Text config:
//        let textLabel = UILabel(frame: CGRect(x: 0, y: 50, width: 80, height: 30))
//        textLabel.textColor = UIColor.white
//        textLabel.textAlignment = .center
//        textLabel.font = UIFont(name: textLabel.font.fontName, size: 13)
//        textLabel.text = "Loading..."
//        
//        // Activate:
//        boxView?.center = CGPoint(x: contactWebView.bounds.size.width/2, y: contactWebView.bounds.size.height/2)
//        boxView?.addSubview(activityView)
//        boxView?.addSubview(textLabel)
//        view.addSubview(boxView!)
//    }
//    
////
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//        // activityIndicator.stopAnimating()
//        
//        boxView?.removeFromSuperview()
//
//    
//    }
    

    func webViewDidFinishLoad(_ webView: UIWebView) {
        contactActivity.stopAnimating()
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        contactActivity.stopAnimating()
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        contactWebView.goBack()
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        contactWebView.goForward()
            }
    

    
@IBAction func callButtonTapped(_ sender: Any) {
    
    let url = URL(string: "tel://18448183367")
    UIApplication.shared.openURL(url!)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
            let url = URL(string: "https://asystguard.com/helpdesk/")
            contactWebView.loadRequest(URLRequest(url: url!))
        

    }
    
   
}
