//
//  ViewController.swift
//  App1
//
//  Created by Glenn Olsson on 2017-08-05.
//  Copyright © 2017 Glenn Olsson. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet var tapRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var gameLabel: UILabel!
    
    var currentHighScore = 1
    var currentPressCount = 1
    
    let defaults = UserDefaults.standard
   
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        let lasthigh = defaults.integer(forKey: highscoreKey)
        let hasStarted = defaults.bool(forKey: firstStartKey)
        let token = defaults.string(forKey: tokenKey)
        
        if let testUsername = defaults.string(forKey: usernameKey){
            //Otherwise doesn't exist
            username = testUsername
        }
        
        print("Token: \(token)")
        
        if(!hasStarted){
            //First launch, must choose a nickname
            print("FIRST LAUNCH")
            
            performSegue(withIdentifier: "startSegue", sender: nil)
        }
        
        if lasthigh>0{
            //Not nil, had highscore
            currentHighScore=lasthigh
        }
        else{
            //Was nil, had no highscore
            currentHighScore=1
        }
        updateGameLabel()
        updateHighScoreLabel(currentHighScore)
        newStart()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        updateGameLabel()
//        updateHighScoreLabel(score: loadHighScore())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateGameLabel(){
        gameLabel.text = "App\(currentPressCount)"
    }
    
    func updateHighScoreLabel(_ text: Int){
        highscoreLabel.text = "\(text)"
    }
    
    func actionPressed(){
        print("Tapped")
        currentPressCount+=1
        score = currentPressCount
        updateGameLabel()
        if currentPressCount > currentHighScore{
            updateHighScoreLabel(currentPressCount)
            currentHighScore = currentPressCount
            defaults.set(currentPressCount, forKey: highscoreKey)
        }
    }
    
    @IBAction func gameButtonTapped(_ sender: Any) {
        actionPressed()
    }
    
}








