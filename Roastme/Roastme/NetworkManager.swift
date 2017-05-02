//
//  NetworkManager.swift
//  Roastme
//
//  Created by Anthony Keelan on 4/30/17.
//  Copyright © 2017 OneDayApps. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    static let sharedInstance = NetworkManager()
    
    let defaultManager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            //need to update
            "test.example.com": .pinCertificates(
                certificates: ServerTrustPolicy.certificates(),
                validateCertificateChain: true,
                validateHost: true
            ),
            //need to update
            "insecure.expired-apis.com": .disableEvaluation
        ]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        return Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
}
