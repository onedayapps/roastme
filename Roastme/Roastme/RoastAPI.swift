//
//  RoastAPI.swift
//  Roastme
//
//  Created by Greg Burlet on 2017-03-26.
//  Copyright © 2017 OneDayApps. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON

/*
 * Class with static members for each Frettable API call.
 * Returns the corresponding response structure or nil if some failure occurs
 *
 * Note: Alamofire will resend set cookies on subsequent requests which will mess up pure token authentication
 *       On requests with no Authorization token, avoid sending cookies to avoid SessionAuthentication
 */
class RoastAPI {
    //static let apiRoot = "https://roastme.com/"
    static let apiRoot = "http://192.168.1.79:8000/"
    
    static let serversDown = "Roastme's servers are down. Try again later!"
    static let generalError = "Oh snap! Something went wrong. Try again later!"

    /*
     * Login a user
     * auth/login/
     */
    static func loginUser(username:String, password:String, callback: @escaping (TokenResponse?, LoginErrorResponse?) -> Void) {
        let url = apiRoot + "auth/login/"
        
        // clear cookies to avoid SessionAuthentication
        let headers = [
            "Cookie": ""
        ]
        let parameters = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let tokenResponse = TokenResponse(token: json["key"].string!)
                        callback(tokenResponse, nil)
                    }
                case .failure:
                    if let httpStatusCode = response.response?.statusCode {
                        switch(httpStatusCode) {
                        case 400:
                            callback(nil, LoginErrorResponse(credentialsErr: "Invalid username and password combination", generalErr: "Error logging in. Try again!"))
                        default:
                            callback(nil, LoginErrorResponse(generalErr: generalError))
                        }
                    } else {
                        callback(nil, LoginErrorResponse(generalErr: serversDown))
                    }
                }
        }
    }
    
    /*
     * Create a new roast
     */
    /*static func createRoast(authToken:String, roastImage:UIImage, caption:String) {
        let url = apiRoot + "roastserv/createroast/"
        let headers = [
            "Authorization": "Token " + authToken
        ]
        
        NetworkManager.sharedInstance.defaultManager.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(UIImageJPEGRepresentation(roastImage, 0.75)!, withName: "roastimage", fileName: "new_roast.jpeg", mimeType: "image/jpeg")
            },
                usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold,
                to: url,
                method: .put,
                headers: headers,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            switch response.response?.statusCode {
                            case .none:
                                callback(nil, serversDown)
                            case .some(200):
                                if let json = response.result.value as? [String:String] {
                                    print(json)
                                }
                            default: break
                                // server error
                                //callback(nil, generalError)
                            }
                        }
                    case .failure: break
                        // error uploading file to servers
                        //callback(nil, generalError)
                    }
            }
        )
    }*/
}
