//
//  HomeViewCell.swift
//  Instagram
//
//  Created by sinbad on 7/13/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class HomeViewCell: UICollectionViewCell {
    
    let homeImg: UIImageView = {
        let imageV  = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.contentMode = .scaleAspectFit
        imageV.clipsToBounds = true
        return imageV
        
    }()
    let userProfileImg: UIImageView = {
        let imageV  = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.contentMode = .scaleAspectFit
        imageV.layer.cornerRadius = 40 / 2
        imageV.clipsToBounds = true
        return imageV
        
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "IOS"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let optionButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("...", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        return button
    }()
    
    let likeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
     //   button.backgroundColor = .red
        return button
    }()
    let commentButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
      //  button.backgroundColor = .red
        return button
    }()
    let sendMessageButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
       // button.backgroundColor = .red
        return button
    }()
    
    let bookmarksButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon").withRenderingMode(.alwaysOriginal), for: .normal)
      //  button.backgroundColor = .red
        return button
    }()
    let captionLabel: UILabel = {
        let label = UILabel()
        //        label.text = "SOMETHING FOR NOW"
        
        let attributedText = NSMutableAttributedString(string: "Username", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: " Some caption text that will perhaps wrap onto the next line", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
        
        attributedText.append(NSAttributedString(string: "1 week ago", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
       // backgroundColor = .green
        addSubview(userProfileImg)
        addSubview(userNameLabel)
        addSubview(optionButton)
        
        userProfileImg.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        userProfileImg.backgroundColor = .red
        
        userNameLabel.anchor(top: topAnchor, leading: userProfileImg.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: CGSize(width: 250, height: 40))
      //  userNameLabel.backgroundColor = .red
        
        optionButton.anchor(top: topAnchor, leading: userNameLabel.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: CGSize(width: 40, height: 40))
        //optionButton.backgroundColor = .red
        
        addSubview(homeImg)
        homeImg.anchor(top: userProfileImg.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: homeImg.frame.width, height: 300))
        
        setupInputFields()
    }
    
    func setupInputFields(){
      
//        let inputView = UIView()
//        inputView.translatesAutoresizingMaskIntoConstraints = false
//        inputView.backgroundColor = .red
        let stackview = UIStackView(arrangedSubviews: [likeButton,commentButton,sendMessageButton])
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
      //  stackview.spacing = 10
        addSubview(stackview)
        
        stackview.anchor(top: homeImg.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil , padding: .init(top: 5, left: 10, bottom: 0, right: 0), size: CGSize(width: 130, height: 40))
        
        addSubview(bookmarksButton)

       bookmarksButton.anchor(top: homeImg.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 10), size: CGSize(width: 40, height: 40))
      
        addSubview(captionLabel)
        captionLabel.anchor(top: bookmarksButton.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 10, right: 10))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
