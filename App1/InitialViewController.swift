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
        
        if(newBot(name: name!)){
         //Go to main page, assign token value and save on
         //device. Also make the bool value true
        }
    }
    
    func newBot(name: String) -> Bool{
        let json: Parameters = [
            "name": "\(name)"
        ]
        
        var success = false;
        
        Alamofire.request("http://192.168.1.2:8080/App1/new", method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                
              let json = try? JSONSerialization.jsonObject(with: data, options: [])
                
             if let dictionary = json as? [String: Any] {
                if let token = dictionary["token"] as? String {
                    // access individual value in dictionary
                    print(token)
                    self.defaults.set(token, forKey: tokenKey)
                    self.defaults.set(true, forKey: firstStartKey)
                    success = true
                }
            }
             else{
                print("ERROR CAUGHT")
                success = false
            }
                
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        return success
    }
    
    func Get(){
        
        let parameters: Parameters = [
            "name": "APPIE",
            "token" : "<,rFl^?W24KVi,"
        ]
        
        // Both calls are equivalent
        Alamofire.request("\(mainURL)/App1/start", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            //print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
          //  print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
}
