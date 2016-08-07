//
//  SignUpController.swift
//  Bump
//
//  Created by alden lamp on 8/6/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var userArray = ["Ann", "User1"]
var userToPhone: [String : String] = ["Ann" : "3477256313" , "test1" : "7322779161"]

class SignUpController: UIViewController {

    @IBOutlet var signUpUsername: UITextField!
    
    @IBOutlet var signUpPassword: UITextField!
    
    @IBOutlet var signUpPhoneNumber: UITextField!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func submit(sender: AnyObject) {
        
        if signUpPassword != nil && signUpUsername != nil && signUpPhoneNumber != nil{
            
            postNewUser(String(signUpUsername), password: String(signUpPassword), phoneNumber: String(signUpPhoneNumber))
            
            NSUserDefaults.standardUserDefaults().setObject("\(signUpPassword.text!)", forKey: "\(signUpUsername.text!)")
            
            currentUser = String(signUpUsername.text!)
            performSegueWithIdentifier("ShowHome", sender: nil)
            
            userArray.append(signUpUsername.text!)
            userToPhone[signUpUsername.text!] = signUpPhoneNumber.text!
        }
        
        
    }
    
    func postNewUser(username: String, password: String, phoneNumber: String){
        
        Alamofire.request(.GET, "https//:www.db4free.net").responseJSON { (response) in
            if let JSON = response.result.value{
                
                
                print(JSON)
                
            }
            print("ruhn")
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
