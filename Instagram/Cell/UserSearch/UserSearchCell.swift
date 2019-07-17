//
//  SearchCell.swift
//  Instagram
//
//  Created by Zahedul Alam on 14/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class UserSearchCell: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.lightGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(profileImageView)
        profileImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: CGSize(width: 50, height: 50))
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.centerYInSuperview()
        // profileImageView.centerXInSuperview()
        
//        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//
        addSubview(usernameLabel)
        usernameLabel.anchor(top: topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        usernameLabel.centerYInSuperview()
//
        let separatorView = UIView() 
        separatorView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(separatorView)  
        separatorView.anchor(top: nil, leading: usernameLabel.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0.5))
//
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
