//
//  Posts.swift
//  Instagram
//
//  Created by sinbad on 7/13/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import Foundation
struct Posts {
    let user : User?
    let imageUrl : String?
    let caption : String
    let createDate : Date
    init(user:User, dict: [String: Any]) {
        self.user = user
        self.imageUrl = dict["imageUrl"] as? String ?? ""
        self.caption = dict["caption"] as? String ?? ""
        
        let secondsForm1970 = dict["createDate"] as? Double ?? 0
        self.createDate = Date(timeIntervalSince1970: secondsForm1970)

    }
}
