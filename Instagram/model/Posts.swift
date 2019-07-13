//
//  Posts.swift
//  Instagram
//
//  Created by sinbad on 7/13/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import Foundation
struct Posts {
    let imageUrl : String?
    init(dict: [String: Any]) {
        self.imageUrl = dict["imageUrl"] as? String ?? ""
    }
}
