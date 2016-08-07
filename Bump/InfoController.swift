//
//  InfoController.swift
//  Bump
//
//  Created by alden lamp on 8/6/16.
//  Copyright © 2016 alden lamp. All rights reserved.
//

import UIKit



var person = [String]()
var peopleOnList = ["test" : person]
var desiese = ""

class InfoController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func dismissKeyboard(){
        
        view.endEditing(true)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBOutlet var userSearch: UISearchBar!
    
    @IBOutlet var UserSearchResult: UILabel!
    
    
    @IBOutlet var stdSearch: UISearchBar!
    
    @IBOutlet var stdSearchResult: UITableView!
    
    var throughSearch = false
    

    @IBAction func logOut(sender: AnyObject) {
    
        currentUser = ""
        performSegueWithIdentifier("logOut", sender: nil)
    
    }
    @IBAction func addPerson(sender: AnyObject) {
        
        person.append(UserSearchResult.text!)
        
    }
    
    
    var searchActive = false
    
    
    
    var stdArray = ["Chancroid", "Chlamydia", "Genital Warts", "Gonorrhea", "Herpatitis B", "Herpes", "HIV/AIDS", "Human Papillomavirus (HPV)", "Molluscum Contagiosum", "Pelvic Inflammatory Disease (PID)", "Pubic Lice (Crabs)", "Scabies", "Syphilis", "Trichomoniasis (Trich)", "Other"]
    
    var filtered = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        userSearch.delegate = self
        stdSearch.delegate = self
        stdSearchResult.delegate = self
        stdSearchResult.dataSource = self
        UserSearchResult.text = "Unidentified User"
        
        
        
        
        
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchBar.tag)
        print(searchText)
        
        if searchBar.tag == 1{
            print(userArray)
            for var i = userArray.count - 1; i > -1; i -= 1{
                
                if searchText == userArray[i]{
                    
                    UserSearchResult.text = searchText
                    break
                }else{
                    UserSearchResult.text = "Unidentified User"
                }
                
            }
            
        }
        
        if searchBar.tag == 2{
            filtered = stdArray.filter({ (text) -> Bool in
                let tmp: NSString = text
                let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range.location != NSNotFound
            })
            if filtered.count == 0{
                
            }
            if searchText == ""{
                searchActive = false
            }else{
                searchActive = true
            }
            
            
            self.stdSearchResult.reloadData()
            
            if searchText != ""{
                
                throughSearch = true
            }else{
                
                throughSearch = false
            }
            
        }
        
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            return filtered.count
        }
        return stdArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        if (searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
            
        }else {
            cell.textLabel?.text = stdArray[indexPath.row]
            
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (throughSearch){
            desiese = filtered[indexPath.row]
            print(desiese)
        }else {
            
            desiese = stdArray[indexPath.row]
            print(desiese)
        }
        
        allertOtherPeople(desiese)
    }
    
    func allertOtherPeople(Desiese: String){
        for var i = person.count - 1; i > 0; i -= 1{
            
            if let phoneToMessage = userToPhone[person[i]]{
                print(phoneToMessage)
                let twilioSID = "ACa53472c53e3e8a477617ac2bcaf6a07e"
                let twilioSecret = "825fd297a8fe82a54997fdfa3aed05d1"
        
                //Note replace + = %2B , for To and From phone number
                let fromNumber = "%2B16466797557"// actual number is +14803606445
                let toNumber = "%2B1\(phoneToMessage)"// actual number is +919152346132
                let message = "Warning, pleases get a checkup, you may have \(desiese)"
        
                // Build the request
                let request = NSMutableURLRequest(URL: NSURL(string:"https://\(twilioSID):\(twilioSecret)@api.twilio.com/2010-04-01/Accounts/\(twilioSID)/SMS/Messages")!)
                request.HTTPMethod = "POST"
                request.HTTPBody = "From=\(fromNumber)&To=\(toNumber)&Body=\(message)".dataUsingEncoding(NSUTF8StringEncoding)
        
                // Build the completion block and send the request
                NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                    print("Finished")
                    if let data = data, responseDetails = NSString(data: data, encoding: NSUTF8StringEncoding) {
                        // Success
                        print("Response: \(responseDetails)")
                    } else {
                        // Failure
                        print("Error: \(error)")
                    }
                }).resume()
            }
            
        }
        
    }
    
    
}
