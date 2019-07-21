//
//  CommentPostCell.swift
//  Instagram
//
//  Created by Zahedul Alam on 17/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import SDWebImage

class CommentPostCell: UICollectionViewCell{
    
    var comments : Comments? {
        didSet {
            self.captionLabel.text = comments?.text
            let url = URL(string: (comments?.user?.profileImage)!)
            self.userCommentImg.sd_setImage(with: url, completed: nil)
            setupAttributedCaption()
        }
    }
    
    
    
    let userCommentImg  : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "user")
        image.contentMode = .scaleAspectFill
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
        
        guard comments != nil else {return}
        guard let text = self.comments?.text else {return }
        
        guard let username = self.comments?.user?.username else { return }
        
        let attributedText = NSMutableAttributedString(string: "\(username) " , attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "\(text)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
       

        
        guard let timeAgoDisplay = comments?.creationDate.timeAgoDisplay() else { return }
        
        attributedText.append(NSAttributedString(string: timeAgoDisplay, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        captionLabel.attributedText = attributedText
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userCommentImg)
        userCommentImg.image = #imageLiteral(resourceName: "user")
        userCommentImg.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        userCommentImg.layer.cornerRadius = 40 / 2
        userCommentImg.clipsToBounds = true
        userCommentImg.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        userCommentImg.centerYInSuperview()
        
        
        addSubview(captionLabel)
        captionLabel.anchor(top: topAnchor, leading: userCommentImg.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10), size: CGSize(width: captionLabel.frame.width, height: captionLabel.frame.height))
       captionLabel.centerYInSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
