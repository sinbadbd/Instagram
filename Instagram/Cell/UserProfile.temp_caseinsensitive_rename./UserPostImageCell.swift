//
//  UserPostImageCell.swift
//  Instagram
//
//  Created by sinbad on 7/13/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class UserPostImageCell: UICollectionViewCell {
    
    var post : Posts? {
        didSet {
            
        }
    }
    
    
    let userProfileImage: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userProfileImage)
        userProfileImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
