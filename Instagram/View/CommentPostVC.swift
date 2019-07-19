//
//  CommentPostVC.swift
//  Instagram
//
//  Created by Zahedul Alam on 17/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Firebase
class CommentPostVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let COMMENT_CELL = "CELL"
    
    var post: Posts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(CommentPostCell.self, forCellWithReuseIdentifier: COMMENT_CELL)
        setComment()
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
       // cell.backgroundColor = .red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    
    let commentInputField : UITextField = {
        let InputField = UITextField()
        InputField.placeholder = "Add a comment..."
        return InputField
    }()
    func setComment(){
        if commentInputField.text != nil {
             postButton.isEnabled = true
        }
    }
    let postButton = UIButton(type: .system)

    lazy var containerView : UIView = {
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 60)
        
        let userProfileCommnetImg = UIImageView()
        // userProfileCommnetImg.backgroundColor = .red
        containerView.addSubview(userProfileCommnetImg)
        userProfileCommnetImg.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        // userProfileCommnetImg.roundedImage()
        userProfileCommnetImg.layer.cornerRadius = 40 / 2
        userProfileCommnetImg.clipsToBounds = true
        userProfileCommnetImg.image = #imageLiteral(resourceName: "user")
        userProfileCommnetImg.contentMode = .scaleAspectFit
        
     
        // commentInputField.backgroundColor = .red
        containerView.addSubview(self.commentInputField)
        self.commentInputField.anchor(top: containerView.topAnchor, leading: userProfileCommnetImg.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 5, bottom: 0, right: 0), size: CGSize(width: 290, height: 40))
        
        
        postButton.backgroundColor = UIColor(white: 0, alpha: 0)
        postButton.setTitle("Post", for: .normal)
        containerView.addSubview(postButton)
       // postButton.isEnabled = false
        postButton.addTarget(self, action: #selector(handelComment), for: .touchUpInside)
        postButton.anchor(top: containerView.topAnchor, leading: self.commentInputField.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 5, bottom: 0, right: 5), size: CGSize(width: 50, height: 40))
        return containerView
    }()
    @objc func handelComment(){
      print("\(commentInputField.text ?? "")")
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let postId = post?.postId ?? ""
        let values = [
            "text" : commentInputField.text ?? "",
            "creationDate" : Date().timeIntervalSince1970,
            "uid" : uid
        ] as [String: Any]
        
        Database.database().reference().child("comments").child(postId).childByAutoId().updateChildValues(values) { (err, ref) in
            if err != nil {
                return
            }
            print("successfully insert comments")
        }
    }
    
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
}
