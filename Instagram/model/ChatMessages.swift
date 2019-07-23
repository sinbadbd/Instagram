//
//  ChatMessages.swift
//  Instagram
//
//  Created by sinbad on 7/20/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import Foundation

struct ChatMessages {
    let message : String
    let isIncoming : Bool
    
    init(dict: [String: Any]) {
        self.message = dict["message"] as? String ?? ""
        self.isIncoming = dict["isIncoming"] as? Bool ?? false
    }
}
