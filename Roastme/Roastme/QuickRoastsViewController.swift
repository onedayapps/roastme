//
//  QuickRoastsViewController.swift
//  Roastme
//
//  Created by Matthew Belley on 4/14/17.
//  Copyright © 2017 OneDayApps. All rights reserved.
//

import Foundation
import UIKit

class QuickRoastsViewController: UIViewController {
    
    @IBOutlet weak var roastImage: UIImageView!
    @IBOutlet weak var roastCaption: UILabel!
    @IBOutlet weak var roastComments: UITableView!
    
   
    
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
        
        
        
        
        RoastAPI.getRoastComments(rid: roastID) //need to add callback etc
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


