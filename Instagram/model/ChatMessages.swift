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
    let fromId : String
    let toId : String
    let currentTime : Int
    let creationDate: Double
    
    init(dict: [String: Any]) {
        self.message = dict["message"] as? String ?? ""
        self.fromId = dict["fromId"] as? String ?? ""
        self.toId = dict["toId"] as? String ?? ""
        self.currentTime = dict["currentTime"] as? Int ?? 0
        self.creationDate = dict["creationDate"] as? Double ?? 0.0
    }
}
