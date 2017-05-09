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

class QuickRoastsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var roastImage: UIImageView!
    @IBOutlet weak var roastCaption: UILabel!
    @IBOutlet weak var roastComments: UITableView!
    
    var numCommentRows : Int?
    var userComments : [Comment] = []
    var roastID:Int = 6 //make random, code on line below may work once Anto pushes roastCount from the server
    // var roastID:Int = arc4random_uniform(roastCount) //make random later
    let firstRoast:Int = 6 //get from DB
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        loadRoast()
        loadComments()
        
        //setup UITableView delegates
      self.roastComments.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        roastComments.delegate = self
        roastComments.dataSource = self
        
        //Guesture recognizers
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRightActions))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeftActions))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
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
                self.numCommentRows = comments?.count
                self.userComments = comments!
                self.roastComments.reloadData()
            } else{
                
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
      
        let commentText = self.userComments[indexPath.row].content
        let saltValue = String(describing: self.userComments[indexPath.row].salt)
        let sauceValue = String(describing: self.userComments[indexPath.row].sauce)
      
        cell.comment.text = commentText
        cell.salt.text = saltValue
        cell.sauce.text = sauceValue
        
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
