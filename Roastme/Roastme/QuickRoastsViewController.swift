//
//  QuickRoastsViewController.swift
//  Roastme
//
//  Created by Matthew Belley on 4/14/17.
//  Copyright © 2017 OneDayApps. All rights reserved.
//

import Foundation
import UIKit

// need to add caching for roasts to eliminate latency ie, store roast data in an array of 3 roasts [prev, current, next]
// need handling for the case where a roast ID does not exist in the DB

class QuickRoastsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var roastImage: UIImageView!
    @IBOutlet weak var roastCaption: UILabel!
    @IBOutlet weak var roastComments: UITableView!
    
    var loadTableFlag : Int = 0
    var numCommentRows : Int?
    var userComments : [Comment] = []
    var roastID:Int = 1 //make random, code on line below may work once Anto pushes roastCount from the server
    // var roastID:Int = arc4random_uniform(roastCount) //make random later
    let firstRoast:Int = 1 //get from DB
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        RoastAPI.getRoastCount(callback: {
            (count: Int?) in
            if count != 0 {
                self.loadRoast()
                self.loadComments()
                self.loadTableFlag = 1
            }
            // Do something about nil
        })
        
        
        
        //setup UITableView delegates

        self.roastComments.register(commentCell.self, forCellReuseIdentifier: "Cell")
        roastComments.delegate = self
        roastComments.dataSource = self
 
        //Guesture recognizers
        if loadTableFlag == 1 {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRightActions))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeftActions))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        }
    }
    
    @IBAction func createComment(_ sender: Any) {
        performSegue(withIdentifier: "createCommentModal", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createCommentModal" {
            let vc = segue.destination as! CreateCommentController
            vc.roastID = roastID
        }
    }
    
    
    
    func swipeLeftActions(gesture: UISwipeGestureRecognizer) {
        nextRoast()

        print("left")
    }
    
    func swipeRightActions(gesture: UISwipeGestureRecognizer) {
        prevRoast()
        loadRoast()
        loadComments()
        print("right")
    }
  
  
    func loadRoast() {
        // get roast info
        
        RoastAPI.getRoast(rid: roastID, callback: {
            (roast:Roast?) in
            if roast != nil {
                
                // download roast image
                let url = URL(string: (roast?.picture)!)
                let data = try? Data(contentsOf: url!)
                
                
                DispatchQueue.main.async{
                    //display roast info
                    self.roastCaption.text = roast?.caption!
                    self.roastImage.image = UIImage(data: data!)
                  
                }
                
            } else {
                // handle nil roast
            }
        })
    }
  
  func nextRoast() {
      
      RoastAPI.getRoastCount(callback: {
        (roastCount:Int?) in
        if roastCount != nil {
          let minRoastID = self.firstRoast
          var roastIndexMax = 0
          var tempRoastID = self.roastID
          
          roastIndexMax = minRoastID + roastCount! - 1
          tempRoastID += 1
          
          self.roastID = min(tempRoastID, roastIndexMax)
          print("roastID \(self.roastID)")
          self.loadRoast()
          self.loadComments()
          
          
        } else {
        }
      })
      

        
    }
    
    func prevRoast() {
        var tempRoastID = roastID
        tempRoastID -= 1
        roastID = max(tempRoastID, firstRoast)
    }
    
    func loadComments() {
        RoastAPI.getRoastComments(rid: roastID, callback: {
            (comments:[Comment]?) in
            if comments != nil {
                //populate table view
                self.loadTableFlag = 1
                self.numCommentRows = comments?.count
                self.userComments = comments!
                self.roastComments.reloadData()
            } else{
                self.loadTableFlag = 0
            }
        })
    }
    
    //table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        guard let rows = numCommentRows else {
            return 0
        }
      //print("rows \(rows)")
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! commentCell
        print("loading tableview")

        if loadTableFlag != 0 {
        let commentText = self.userComments[indexPath.row].content
        let saltValue = String(describing: self.userComments[indexPath.row].salt)
        let sauceValue = String(describing: self.userComments[indexPath.row].sauce)
        
        cell.comment?.text = commentText
        cell.salt?.text = saltValue
        cell.sauce?.text = sauceValue
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}

class commentCell: UITableViewCell {
  @IBOutlet weak var comment: UILabel!
  @IBOutlet weak var sauce: UILabel!
  @IBOutlet weak var salt: UILabel!
  
}
