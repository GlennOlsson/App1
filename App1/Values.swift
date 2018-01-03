//
//  Values.swift
//  App1
//
//  Created by Glenn Olsson on 2017-12-09.
//  Copyright © 2017 Glenn Olsson. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

let tokenKey = "token"
let firstStartKey = "hasStarted"
let highscoreKey = "highscore"
let usernameKey = "username"

let mainURL = "http://glennolsson.se/App1/api"

var username: String = ""

let defaults = UserDefaults.standard

var globalGameLabel: UILabel?

var currentHighScore: Int = 1

var currentPressCount = 1

func newBot(name: String) -> Bool{
    
    return true
}

/*
func updateHighscoreRequest(){
    
    let requestJson: Parameters = [
        "token": "\(String(describing: tempToken))",
        "score": tempScore
    ]
    
    Alamofire.request("\(mainURL)/App1/update", method: .post, parameters: requestJson, encoding: JSONEncoding.default).responseJSON {
        response in
        
        if let data = response.data{
            
            do{
                let responseJSON = try JSON(data: data)
                let highscoreArray = responseJSON["highscore"].arrayValue
                
                HighscoreViewController.updateHighscore(highscoreArray: highscoreArray)
                
                print(highscoreArray)
            }
            catch{
                print("BAD RESPONSE")
            }
            
            print("updated array")
        }
    }
}

 */

func newStart(){
    
    if let token = defaults.string(forKey: tokenKey){
    
    let json: Parameters = [
        "token": "\(String(describing: token))"
    ]
    
    Alamofire.request("\(mainURL)/start", method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { response in
        if let data = response.data{
            
            let statusCode = response.response?.statusCode
            
            print("Status code: \(statusCode)")
            
            if(statusCode == 401){
                print("No user with that token exists")
            }
            else if(statusCode == 402){
                print("Token was none")
            }
            else if(statusCode == 200){
                print("New Start")
            }
            else{
                print("Unkown response code. Might be an internal error on server")
            }
        }
    }
    }
}
