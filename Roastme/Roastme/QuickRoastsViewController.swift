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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         // get roast info
        let roastID = "2"
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
        
        
        
        
        RoastAPI.getRoastComments(rid: roastID, callback: {
            (comments:[Comment]?) in
            if comments != nil {
                //populate table view
                self.numCommentRows = comments?.count
                self.userComments = comments!
                self.roastComments.reloadData()
            } else{
                
            }
        }) //need to add callback etc
       
        
        //setup UITableView delegates
        self.roastComments.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        roastComments.delegate = self
        roastComments.dataSource = self
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


