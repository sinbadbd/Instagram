//
//  HomeViewCell.swift
//  Instagram
//
//  Created by sinbad on 7/13/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import SDWebImage

protocol HomePostCellDelegate {
    func didTapComment(post: Posts)
    func didLike(for cell: HomeViewCell)
}

class HomeViewCell: UICollectionViewCell {
    
    
    var delegate : HomePostCellDelegate?
    
    var post : Posts? {
        didSet {
            self.captionLabel.text = post?.caption
            
            let url = URL(string: (post?.imageUrl)!)
            self.homeImg.sd_setImage(with: url, completed: nil)
            self.userNameLabel.text = post?.user?.username
            let prifileUrl = URL(string: (post?.imageUrl)!)
            self.userProfileImg.sd_setImage(with: prifileUrl, completed: nil)
            
            let likeActive = (post?.hasLike == true)
            
            likeButton.setImage( likeActive ? #imageLiteral(resourceName: "like_selected").withRenderingMode(.alwaysOriginal) : #imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
            //likeButton.tintColor = .red
           
            
            
            setupAttributedCaption()
        }
    }
    func setupAttributedCaption (){
        guard let post = self.post else { return }
        
        guard let username = post.user?.username else {return}
        
        let attributedText = NSMutableAttributedString(string: username, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: " \(post.caption)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
        
        let timeAgoDisplay = post.createDate.timeAgoDisplay()
        
        attributedText.append(NSAttributedString(string: "\(timeAgoDisplay)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        captionLabel.attributedText = attributedText
        
    }
    
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
        imageV.contentMode = .scaleAspectFill
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
    
    lazy var likeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        //button.backgroundColor = .red
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return button
    }()
    lazy var commentButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
      //  button.backgroundColor = .red
        button.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
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
        label.numberOfLines = 0
        label.text = "haha"
        label.translatesAutoresizingMaskIntoConstraints = false
       // label.backgroundColor = .blue
        return label
    }()

    @objc func handleLike (){
        print("1234..")
        delegate?.didLike(for: self)
    }
    
    @objc func handleComment(){
        print("hi")
        guard let post = post else {return}
        
        delegate?.didTapComment(post: post)
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      //  backgroundColor = .green
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

        addSubview(captionLabel)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false

        captionLabel.anchor(top: likeButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,  padding: .init(top: 0, left: 10, bottom: 10, right: 10),size: CGSize(width: captionLabel.frame.width, height: captionLabel.frame.height))
     //   captionLabel.backgroundColor = .red
        
    }
    
    func setupInputFields(){
      
        let stackview = UIStackView(arrangedSubviews: [likeButton,commentButton,sendMessageButton])
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fillEqually
       // stackview.axis = .horizontal
      //  stackview.spacing = 10
        addSubview(stackview)
        stackview.backgroundColor = .red
        stackview.anchor(top: homeImg.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil , padding: .init(top: 5, left: 10, bottom: 0, right: 0), size: CGSize(width: 130, height: 40))
        
        addSubview(bookmarksButton)

       bookmarksButton.anchor(top: homeImg.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 10), size: CGSize(width: 40, height: 40))

     }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
