//
//  QuickRoastsViewController.swift
//  Roastme
//
//  Created by Matthew Belley on 4/14/17.
//  Copyright © 2017 OneDayApps. All rights reserved.
//

import Foundation
import UIKit

class QuickRoastsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var roastImage: UIImageView!
    @IBOutlet weak var roastCaption: UILabel!
    @IBOutlet weak var roastComments: UITableView!
    
    var numCommentRows : Int?
    var userComments : [Comment] = []
    var roastID:Int = 2 //make random later
    var roastCount:Int = 5 //modify to get count of roasts from DB
    let firstRoast:Int = 2 //get from DB
    
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
        var tempRoastID = roastID
        tempRoastID += 1
        roastID = min(tempRoastID, roastCount)
        //neet to add validation for number of roasts
        
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
        print(rows)
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        print("loading tableview")
        
        cell.textLabel?.text = self.userComments[indexPath.row].content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}


