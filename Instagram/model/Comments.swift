//
//  Comments.swift
//  Instagram
//
//  Created by sinbad on 7/18/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import Foundation
struct Comments {
    
    var user : User?
    
    let text : String
    let uid : String
    let creationDate : Date
    
    init(dic: [String: Any]) {
        self.text = dic["text"] as? String ?? ""
        self.uid = dic["uid"] as? String ?? ""
        
        let secondsForm1970 = dic["createDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsForm1970)
    }
}
