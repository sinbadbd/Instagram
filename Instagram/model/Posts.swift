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
    let createDate : String
    init(user:User, dict: [String: Any]) {
        self.user = user
        self.imageUrl = dict["imageUrl"] as? String ?? ""
        self.caption = dict["caption"] as? String ?? ""
        self.createDate = dict["createDate"] as? String  ?? ""

    }
}
