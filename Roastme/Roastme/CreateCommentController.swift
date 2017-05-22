//
//  CreateCommentController.swift
//  Roastme
//
//  Created by Anthony Keelan on 5/3/17.
//  Copyright © 2017 OneDayApps. All rights reserved.
//

import Foundation
import UIKit

protocol createCommentDelegate {
    func myVCDdidFinish(controller:CreateCommentController)
}

class CreateCommentController: UIViewController {
    

    @IBOutlet weak var commentTextView: UITextView!
    let currentToken = User.sharedInstance.authToken
    var roastID:Int? = nil
    var delegate:createCommentDelegate! = nil
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        let comment = commentTextView.text
        if comment != nil {
            RoastAPI.createComment(authToken: currentToken!, content: comment!, roastID: roastID!, callback: {
                (success:createCommentResponse?, error:LoginErrorResponse?) in
                if success != nil {
                    // print(success?.response!)
                    self.dismiss(animated: true, completion: nil)
                    if self.delegate != nil {
                        self.delegate!.myVCDdidFinish(controller: self)
                    }
                
                } else {
                    print("back to the drawing board")
                    print(error!)
                }
            })
        } else {
            // TODO: ask user to type a comment
        }

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateRoastController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    
    }
    
    func dismissKeyboard() {
    view.endEditing(true)
    }
    


}

