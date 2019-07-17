//
//  CommentPostCell.swift
//  Instagram
//
//  Created by Zahedul Alam on 17/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class CommentPostCell: UICollectionViewCell{
    
    let userCommentImg  : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "user")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(userCommentImg)
        userCommentImg.image = #imageLiteral(resourceName: "user")
        userCommentImg.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
