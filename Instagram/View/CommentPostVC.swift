//
//  CommentPostVC.swift
//  Instagram
//
//  Created by Zahedul Alam on 17/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class CommentPostVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let COMMENT_CELL = "CELL"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(CommentPostCell.self, forCellWithReuseIdentifier: COMMENT_CELL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: COMMENT_CELL, for: indexPath) as! CommentPostCell
        cell.backgroundColor = .red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    
    
    
    override var inputAccessoryView: UIView? {
        get {
            let containerView = UIView()
            containerView.backgroundColor = .white
            containerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
            
            
            
            let userProfileCommnetImg = UIImageView()
            userProfileCommnetImg.backgroundColor = .red
            containerView.addSubview(userProfileCommnetImg)
            userProfileCommnetImg.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
           // userProfileCommnetImg.roundedImage()
            userProfileCommnetImg.layer.cornerRadius = 40 / 2
            userProfileCommnetImg.clipsToBounds = true
            
            
            let commentInputField = UITextField()
            commentInputField.placeholder = "Add a comment..."
           // commentInputField.backgroundColor = .red
            containerView.addSubview(commentInputField)
            commentInputField.anchor(top: containerView.topAnchor, leading: userProfileCommnetImg.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 5, bottom: 0, right: 0), size: CGSize(width: 290, height: 40))
            
            
            let postButton = UIButton(type: .system)
            postButton.backgroundColor = UIColor(white: 0, alpha: 0)
            postButton.setTitle("Post", for: .normal)
            containerView.addSubview(postButton)
            postButton.anchor(top: containerView.topAnchor, leading: commentInputField.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 5, bottom: 0, right: 5), size: CGSize(width: 50, height: 40))
            
            
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
}
