//
//  highscoreTableViewController.swift
//  App1
//
//  Created by Glenn Olsson on 2017-12-11.
//  Copyright © 2017 Glenn Olsson. All rights reserved.
//

import Foundation
import UIKit

class HighscoreTableViewController: UITableViewController{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Use your cell's reuse identifier and cast the result
        // to your custom table cell class.
        let cell = tableView.dequeueReusableCell(withIdentifier: "highscoreCell", for: indexPath)
        
        // You should have access to your labels; assign the values.
        cell.textLabel!.text="HEJ"
        cell.detailTextLabel!.text="Hejjjejjejjeje"
        
        return cell
    }
}
