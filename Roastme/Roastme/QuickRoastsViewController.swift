//
//  QuickRoastsViewController.swift
//  Roastme
//
//  Created by Matthew Belley on 4/14/17.
//  Copyright © 2017 OneDayApps. All rights reserved.
//

import Foundation
import UIKit

//need function to get a list of roast ids based on criteria like date range(today, this week, this month, upvotes, upvotes+date range, or in sequential order) then store the roast ids in an array and walk through them when going to next roast etc

class QuickRoastsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var roastImage: UIImageView!
    @IBOutlet weak var roastCaption: UILabel!
    @IBOutlet weak var roastComments: UITableView!
    
    var loadTableFlag: Int = 0
    var numCommentRows: Int?
    var userComments: [Comment] = []
    var roastIndex:Int = 0 //make random, code on line below may work once Anto pushes roastCount from the server
    // var roastID:Int = arc4random_uniform(roastCount) //make random later
    var rIDs: [Int] = []
    var roastHistory: [Int] = []
    let noRoastsErr = "No Roasts Found"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RoastAPI.getRIDlist(callback: {
            (ids:[Int]?) in
            if ids != nil {
                self.rIDs = ids!
                print(self.rIDs[self.roastIndex])
                self.loadRoast()
                self.loadComments()
            } else {
                //error handling
            }
        })
        
        //setup UITableView delegates

        self.roastComments.register(commentCell.self, forCellReuseIdentifier: "Cell")
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
            vc.roastID = rIDs[roastIndex]
        }
    }
    
    
    
    func swipeLeftActions(gesture: UISwipeGestureRecognizer) {
        nextRoast()
        loadRoast()
        loadComments()
        print("left")
    }
    
    func swipeRightActions(gesture: UISwipeGestureRecognizer) {
        prevRoast()
        loadRoast()
        loadComments()
        print("right")
    }
    
    func getRIDs() {
        RoastAPI.getRIDlist(callback: {
            (ids:[Int]?) in
            if ids != nil {
                self.rIDs = ids!
                print(self.rIDs)
            } else {
                //error handling
            }
        })
    }
  
  
    func loadRoast() {
        // get roast info
        
        RoastAPI.getRoast(rid: rIDs[roastIndex], callback: {
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
    if roastHistory.count < rIDs.count {
        // for if we do random roast selection
        roastHistory.append(rIDs[roastIndex])
    } else if roastIndex > rIDs.count - 2 {
        // check for more roasts when user gets to end of their roast list
        getRIDs()
    }
    
        var tempRoastID = roastIndex
        let roastIndexMax = rIDs.count - 1
    
        tempRoastID += 1
          
        roastIndex = min(tempRoastID, roastIndexMax)
        print("roastID \(self.roastIndex)")
    

    }
    
    func prevRoast() {

        var tempRoastID = roastIndex
        tempRoastID -= 1
        roastIndex = max(tempRoastID, 0)
        
    }
    
    func loadComments() {
        RoastAPI.getRoastComments(rid: rIDs[roastIndex], callback: {
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
