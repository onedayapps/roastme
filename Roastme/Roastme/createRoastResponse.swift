//
//  createRoastResponse.swift
//  Roastme
//
//  Created by Anthony Keelan on 4/30/17.
//  Copyright © 2017 OneDayApps. All rights reserved.
//

import Foundation


struct createRoastResponse {
    let response:[String:String]?
    
    init(response:[String:String]? = nil) {
        self.response = response
        
    }
}

struct createCommentResponse {
    let response:Int?
    
    init(response: Int? = nil) {
        self.response = response
    }
}
