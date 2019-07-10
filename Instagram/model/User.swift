//
//  User.swift
//  Instagram
//
//   on 10/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import Foundation

struct User {
    let username : String
    let profileImage : String

    init(dict : [String: Any] ) {
        self.username = dict["username"]  as? String ?? ""
        self.profileImage = dict["profileImageUrl"] as? String ?? ""
    }
}
