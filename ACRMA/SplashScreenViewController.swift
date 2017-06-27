//
//  SplashScreenViewController.swift
//  ACRMA
//
//  Created by Apogee on 6/7/17.
//  Copyright © 2017 Kode. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        perform("showSlapshScreen", with: nil, afterDelay: 2)

        // Do any additional setup after loading the view.
    }
    
    func showSlapshScreen()
    {
        performSegue(withIdentifier: "SplashScreen", sender: self)
        
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
