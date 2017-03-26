//
//  LoginErrorResponse.swift
//  Frettable
//
//  Created by Greg Burlet on 2016-06-27.
//  Copyright © 2016 Frettable. All rights reserved.
//

import Foundation

struct LoginErrorResponse {
    let credentialsErr:String?
    let generalErr:String?
    
    init(credentialsErr:String? = nil, generalErr:String? = nil) {
        self.credentialsErr = credentialsErr
        self.generalErr = generalErr
    }
}