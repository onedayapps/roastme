//
//  Login.swift
//  Roastme
//
//  Created by Anthony Keelan on 4/1/17.
//  Copyright © 2017 OneDayApps. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController:UIViewController{
    
    let ROAST_SEGUE_ID = "loginToRoast"

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!

    @IBAction func Login(_ sender: Any) {
        let username = self.Username.text
        let password = self.Password.text
        
        RoastAPI.loginUser(username: username!, password: password!, callback: {
            (tokenResponse:TokenResponse?, loginErr:LoginErrorResponse?) in
            if tokenResponse != nil {
                print(tokenResponse!.token)
                self.performSegue(withIdentifier: self.ROAST_SEGUE_ID, sender: self)
            } else {
                print(loginErr?.credentialsErr)
            }
        })
    }
}

