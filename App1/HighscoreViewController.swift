//
//  HighscoreViewController.swift
//  App1
//
//  Created by Glenn Olsson on 2017-12-09.
//  Copyright © 2017 Glenn Olsson. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

class HighscoreViewController: UIViewController, UIApplicationDelegate{
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var highscoreLabelStack: UIStackView!
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("RESIGN ACTIVE")
        updateHighscoreRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded Highscore")
//        updateHigh()
        newStart()
        updateHighscoreRequest()
    }
    
   func updateHighscore(highscoreArray: [JSON]){
    
    //Clearing stack before adding new content
    while let subview = highscoreLabelStack.subviews.last {
        subview.removeFromSuperview()
    }
    
        for var i in 0..<highscoreArray.count{
            let thisObject = highscoreArray[i].dictionaryObject
            let name = thisObject!["name"] as! String
            let score = thisObject!["score"] as! Int
            
            print("Nr \(i): \(name) - \(score)")
            
            //Creating two new labels for the name and score, then adding them to a new
            //stack, which will then be added to the root stack
            
            let newStack = createStackAndLabels(name: name, score: score)
            
            print(newStack.heightAnchor.debugDescription)
            
            highscoreLabelStack.addArrangedSubview(newStack)
            
            
            let constraintHeight = NSLayoutConstraint (item: newStack,
                                                           attribute: NSLayoutAttribute.height,
                                                           relatedBy: NSLayoutRelation.equal,
                                                           toItem: nil,
                                                           attribute: NSLayoutAttribute.notAnAttribute,
                                                           multiplier: 1,
                                                           constant: 20)
            
            highscoreLabelStack.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addConstraint(constraintHeight)
                        
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func createStackAndLabels(name: String, score: Int) -> UIStackView{
        let stack = UIStackView(frame: self.view.bounds)
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        stack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stack.setNeedsUpdateConstraints()
        
        let nameLabel = UILabel()
        nameLabel.text = name
        
        let scoreLabel = UILabel()
        scoreLabel.text = String(score)
        
        
        
        
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(scoreLabel)
        
        return stack
    }
    
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
                    
                    self.updateHighscore(highscoreArray: highscoreArray)
                    
                    print(highscoreArray)
                }
                catch{
                    print("BAD RESPONSE")
                }
                
                print("updated array")
            }
        }
        
        print("DONE")
        
    }
    
    /*func updateHigh(){
        let score = defaults.integer(forKey: highscoreKey)
        let token = "OPl5gRg(.TUct#" //defaults.string(forKey: tokenKey)
        
        let json: Parameters = [
            "token": "\(String(describing: token))",
            "score" : score
        ]
        
        print(json)
        
        Alamofire.request("\(mainURL)/App1/update", method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                
            let jsons = try? JSONSerialization.jsonObject(with: data, options: [])
            
                if let dictionary = jsons as? [String: Any] {
                    if let array = dictionary["highscore"] as? [Any] {
                        for var i in (0..<array.count){
                            var person = array[i] as! [String: Any]
                            var horStack = self.stackView.arrangedSubviews[0] as! UIStackView
                            //first index is a label
                            var finalStack = horStack.arrangedSubviews[i + 1] as! UIStackView
                            
                            var nameLabel = finalStack.arrangedSubviews[0] as! UILabel
                            var scoreLabel = finalStack.arrangedSubviews[1] as! UILabel
                            nameLabel.text = person["name"] as! String
                            scoreLabel.text = String(person["score"] as! Int)
                        }
                    }
                    else{
                        print("Y")
                    }
                }
                else{
                    print(jsons)
                }
            }
        }
        
    }*/
    
}
