//
//  InitialViewController.swift
//  App1
//
//  Created by Glenn Olsson on 2017-12-09.
//  Copyright © 2017 Glenn Olsson. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class InitialViewController: UIViewController {
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var confimButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AYY")
        errorLabel.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func confirmPress(_ sender: Any) {
        let name = nicknameTextField.text;
        
        if(name == nil){
            return
        }
        
        newBot(name: name!)
         
    }
    
    func newBot(name: String){
        let json: Parameters = [
            "name": "\(name)"
        ]
        
        print("\(mainURL)/new")
        
        Alamofire.request("\(mainURL)/new", method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data {
                var statusCode = response.response?.statusCode
                
                print("Status code: \(statusCode)")
                
                if(statusCode == 401){
                    self.errorLabel.text = "A user with that name already exists"
                }
                else if(statusCode == 402){
                    self.errorLabel.text = "The name field is empty"
                }
                else if(statusCode == 200){
                //Success
                do{
                    let responseJSON = try JSON(data: data)
                    let token = responseJSON["token"].stringValue
                    
                    print(token)

                    self.defaults.set(name, forKey: usernameKey)
                    self.defaults.set(token, forKey: tokenKey)
                    self.defaults.set(true, forKey: firstStartKey)
                    
                    username = name
                    
                    print("Successfully created new user")
                    
                    //Go to main page, assign token value and save on
                    //device. Also make the bool value true
                    
                    self.performSegue(withIdentifier: "initialToMain", sender: nil)
                    
                    self.errorLabel.textColor = UIColor.green
                    self.errorLabel.text = "Success"
                    
                }
                catch{
                    print("BAD RESPONSE")
                    }
                }
                else{
                    print("Unkown response code. Might be an internal error on server")
                }
            }
        }
    }
}
