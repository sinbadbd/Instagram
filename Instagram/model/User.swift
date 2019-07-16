//
//  User.swift
//  Instagram
//
//   on 10/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let username : String
    let profileImage : String

    init(uid: String, dict : [String: Any] ) {
        self.uid = uid
        self.username = dict["username"]  as? String ?? ""
        self.profileImage = dict["profileImageUrl"] as? String ?? ""
    }
}

