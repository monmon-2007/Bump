//
//  LogInController.swift
//  Bump
//
//  Created by alden lamp on 8/7/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit

var currentUser = ""

class LogInController: UIViewController {
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBOutlet var incorrectUsername: UILabel!
    
    @IBOutlet var logInUsername: UITextField!
    
    @IBOutlet var logInPassword: UITextField!
    
    @IBAction func logIn(sender: AnyObject) {
        
        if logInUsername != nil && logInPassword != nil{
            
            var username = String(logInUsername.text!)
            
            if let passwordPerUsername: String = NSUserDefaults.standardUserDefaults().objectForKey(username)! as! String{
            
            
            
            if logInPassword.text == String(passwordPerUsername){
                
                print("logged in")
                currentUser = String(logInUsername.text!)
                performSegueWithIdentifier("ShowHome", sender: nil)
                
            }else{
                print("failed to log in 1")
                
                incorrectUsername.hidden = false
                
                }
            }else{
                
                print("failed to log in")
            }
            
        }
        
        
    }
    

    func dismissKeyboard(){
        
        view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
