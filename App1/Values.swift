//
//  Values.swift
//  App1
//
//  Created by Glenn Olsson on 2017-12-09.
//  Copyright © 2017 Glenn Olsson. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let tempToken = "<,rFl^?W24KVi,"
let tempScore = 9

let tokenKey = "token"
let firstStartKey = "hasStarted"
let highscoreKey = "highscore"

let mainURL = "http://192.168.1.2:8080/"

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
    let json: Parameters = [
        "token": "\(String(describing: tempToken))"
    ]
    
    Alamofire.request("\(mainURL)App1/start", method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { response in
       print("New Start")
    }
}
