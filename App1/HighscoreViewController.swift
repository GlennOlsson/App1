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

class HighscoreViewController: UIViewController{
    
    let defaults = UserDefaults.standard
	
    @IBOutlet weak var highscoreLabelStack: UIStackView!
	
    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateHigh()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        //Clearing stack before adding new content
        while let subview = highscoreLabelStack.subviews.last {
            subview.removeFromSuperview()
        }
        
        loadingIcon.startAnimating()
		updateHighscoreRequest()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//         updateHighscoreRequest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func updateHighscoreRequest(){
        
        if let token = defaults.string(forKey: tokenKey){
            
        let requestJson: Parameters = [
            "token": "\(token)",
            "score": defaults.integer(forKey: highscoreKey)
        ]
        
        Alamofire.request("\(mainURL)/update", method: .post, parameters: requestJson, encoding: JSONEncoding.default).responseJSON {
            response in
            
            if let data = response.data{
                
                let statusCode = response.response?.statusCode
                
                print("Status code: \(statusCode)")
                
                if(statusCode == 401){
                    print("A user with that name already exists")
                }
                else if(statusCode == 402){
                    print("The name field is empty")
                }
                else if(statusCode == 200 || statusCode == 201){
                do{
                    let responseJSON = try JSON(data: data)
                    self.updateHighscore(highscoreObject: responseJSON)
                    
                    print(responseJSON.debugDescription)
                }
                catch{
                    print("BAD RESPONSE")
                }
                }
                else{
                    print("Unkown response code. Might be an internal error on server")
                }
                print("updated array")
            }
        }
        
	}
    }
	func updateHighscore(highscoreObject: JSON){
		
		
		let thisUserSpot = highscoreObject["thisUserSpot"].intValue
		
		let highscoreArray = highscoreObject["highscore"].arrayValue
		
        loadingIcon.stopAnimating()
        
		for var i in 0..<highscoreArray.count{
			let thisObject = highscoreArray[i].dictionaryObject
			let name = thisObject!["name"] as! String
			let score = thisObject!["score"] as! Int
			
			print("Nr \(i+1): \(name) - \(score)")
			
			//Creating two new labels for the name and score, then adding them to a new
			//stack, which will then be added to the root stack
			
			let newStack = createStackAndLabels(name: name, score: score, highSpot: i+1, isThisUser: i == thisUserSpot)
            
			highscoreLabelStack.addArrangedSubview(newStack)
			
			
			/* let constraintHeight = NSLayoutConstraint (item: newStack,
			attribute: NSLayoutAttribute.height,
			relatedBy: NSLayoutRelation.equal,
			toItem: nil,
			attribute: NSLayoutAttribute.notAnAttribute,
			multiplier: 1,
			constant: 20)
			*/
			
			highscoreLabelStack.translatesAutoresizingMaskIntoConstraints = false
			
			//            self.view.addConstraint(constraintHeight)
			
		}
		if thisUserSpot > 9{
			//Not on top 10
			
			let newStack = createStackAndLabels(name: username, score: defaults.integer(forKey: highscoreKey), highSpot: thisUserSpot + 1, isThisUser: true)
			
			highscoreLabelStack.addArrangedSubview(newStack)
			highscoreLabelStack.translatesAutoresizingMaskIntoConstraints = false
		}
	}
	
	func createStackAndLabels(name: String, score: Int, highSpot: Int, isThisUser: Bool) -> UIStackView{
		let stack = UIStackView(frame: self.view.bounds)
		stack.axis = .horizontal
		stack.distribution = .fill
		stack.alignment = .fill
		stack.spacing = 5
		stack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		stack.setNeedsUpdateConstraints()
		
		let nameLabel = UILabel()
		nameLabel.text = "\(highSpot):  \(name)"
		
		let scoreLabel = UILabel()
		scoreLabel.text = String(score)
		
		if(isThisUser){
			print("isthisuser!!")
				//This user is on top 10, marking that
				nameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
				scoreLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
		}
		
		stack.addArrangedSubview(nameLabel)
		stack.addArrangedSubview(scoreLabel)
		
		return stack
	}
	
}
