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
    let captionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        // label.backgroundColor = .blue
        return label
    }()
    func setupAttributedCaption (){
    //    guard let post = self.post else { return }
        
       // guard let username = post.user?.username else {return}
        
        let attributedText = NSMutableAttributedString(string: "Imran", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "  The ArticleViewModel conforms to the Identifiable  since it has to supply data to the List. The List uses the id property to make sure that the contents of the list are unique.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
       

        
       // let timeAgoDisplay = post.createDate.timeAgoDisplay()
        
        attributedText.append(NSAttributedString(string: "10 Days", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        captionLabel.attributedText = attributedText
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAttributedCaption()
        addSubview(userCommentImg)
        userCommentImg.image = #imageLiteral(resourceName: "user")
        userCommentImg.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        userCommentImg.centerYInSuperview()
        
        addSubview(captionLabel)
        captionLabel.anchor(top: topAnchor, leading: userCommentImg.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10), size: CGSize(width: captionLabel.frame.width, height: captionLabel.frame.height))
       captionLabel.centerYInSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
