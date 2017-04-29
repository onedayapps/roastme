//
//  User.swift
//  Roastme
//
//  Created by Anthony Keelan on 4/29/17.
//  Copyright © 2017 OneDayApps. All rights reserved.
//

import Foundation

class User {
    static let sharedInstance = User()
    
    //properties
    var authToken : String?
    var email : String?
    var username : String?
    
    private init() { }
    
    
}
