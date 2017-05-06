//
//  Comment.swift
//  Roastme
//
//  Created by Anthony Keelan on 4/14/17.
//  Copyright © 2017 OneDayApps. All rights reserved.
//

import Foundation
import SwiftyJSON

class Comment{
    var content: String?
    var upvotes: Int?
    var sauce: Int?
    var salt: Int?
    var roaster: String?
    var roast: Int?
    var commentDate: String?
    
    required init(json: JSON) {
        self.content = json[CommentFields.content.rawValue].string
        self.upvotes = json[CommentFields.upvotes.rawValue].int
        self.sauce = json[CommentFields.sauce.rawValue].int
        self.salt = json[CommentFields.salt.rawValue].int
        self.roaster = json[CommentFields.roaster.rawValue].string
        self.roast = json[CommentFields.roast.rawValue].int
        self.commentDate = json[CommentFields.commentDate.rawValue].string
        }
}
extension Comment {
    enum CommentFields: String {
        case content = "content"
        case upvotes = "upvotes"
        case sauce = "sauce"
        case salt = "salt"
        case roaster = "roaster"
        case roast = "roast"
        case commentDate = "commentDate"
        
    }
}
