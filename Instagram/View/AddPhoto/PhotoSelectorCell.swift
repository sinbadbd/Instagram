//
//  PhotoSelectorCell.swift
//  Instagram
//
//  Created by sinbad on 7/12/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class PhotoSelectorCell : UICollectionViewCell {
    
    let photoImageView : UIImageView = {
        let image = UIImageView() 
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
