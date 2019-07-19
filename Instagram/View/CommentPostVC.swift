//
//  CommentPostVC.swift
//  Instagram
//
//  Created by Zahedul Alam on 17/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class CommentPostVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let COMMENT_CELL = "CELL"
    
    var post: Posts?
    var comments = [Comments]()
    var user: User?
    
    var commentsIcon = ["😀", "😍", "😛", "🙌","❤️","🔥","🙊","🍎"]
    
    let userProfileCommnetImg = UIImageView()
    let postButton = UIButton(type: .system)
    
    let commentInputField : UITextField = {
        let InputField = UITextField()
        InputField.placeholder = "Add a comment..."
        return InputField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(CommentPostCell.self, forCellWithReuseIdentifier: COMMENT_CELL)
        setComment()
        fetchComments()
    }
    
    
    func fetchComments(){
        guard let posId = self.post?.postId else { return }
        let ref = Database.database().reference().child("comments").child(posId)
        
        ref.observe(.childAdded, with: { (snap) in
            
            
            guard let dictionary = snap.value as? [String : Any] else { return }
            
            guard let uid = dictionary["uid"] as? String else { return }
            
            Database.fetchUserWithUID(uid: uid, completion: { (user) in
                var comment = Comments(dic: dictionary)
                print(comment)
                comment.user = user
                self.comments.append(comment)
                self.collectionView.reloadData()
            })
            
            
        }) { (err) in
            print(err)
        }
        
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.fetchUserWithUID(uid: uid) { (user) in
            let url = URL(string: user.profileImage)
            self.userProfileCommnetImg.sd_setImage(with: url, completed: nil)
        }
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
        return comments.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: COMMENT_CELL, for: indexPath) as! CommentPostCell
        cell.comments = comments[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    
    func setComment(){
        if commentInputField.text != nil {
            postButton.isEnabled = true
        }
    }
    
    
    lazy var containerView : UIView = {
        
        let topBorder = UIView()
        topBorder.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        topBorder.layer.borderWidth = 1
        
        let containerView = UIView()
        //containerView.backgroundColor = .green
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let commentsEmojiView = UIView()
        containerView.addSubview(commentsEmojiView)
        commentsEmojiView.anchor(top: nil, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(), size: CGSize(width: 100, height: 40))
        commentsEmojiView.backgroundColor = .white
        
        var xPos = 2
        for (emoji, index) in commentsIcon.enumerated() {
          
          //  let emo = commentsIcon[emoji]
            print(emoji)
            var emojiButton = UIButton()
            emojiButton.frame = CGRect(x: xPos, y: 0, width: 50, height: 40)
            emojiButton.setTitle("\(index)", for: .normal)
            emojiButton.setTitleColor(UIColor.black, for: .normal)
           // emojiButton.tag = "\(Int(index))"
            emojiButton.addTarget(self, action: #selector(handleEmojiButton), for: .touchUpInside)
            commentsEmojiView.addSubview(emojiButton)
            xPos += 50
        }
        
        //
 
        //commentsIcon
        containerView.addSubview(topBorder)
        topBorder.anchor(top: commentsEmojiView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 0.5))
        
        // userProfileCommnetImg.backgroundColor = .red
        containerView.addSubview(userProfileCommnetImg)
        userProfileCommnetImg.anchor(top: topBorder.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        // userProfileCommnetImg.roundedImage()
        userProfileCommnetImg.layer.cornerRadius = 40 / 2
        userProfileCommnetImg.clipsToBounds = true
        userProfileCommnetImg.image = #imageLiteral(resourceName: "user")
        userProfileCommnetImg.contentMode = .scaleAspectFill
        
        
        // commentInputField.backgroundColor = .red
        containerView.addSubview(self.commentInputField)
        self.commentInputField.anchor(top: topBorder.bottomAnchor, leading: userProfileCommnetImg.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 5, bottom: 0, right: 0), size: CGSize(width: 290, height: 40))
        
        
        postButton.backgroundColor = UIColor(white: 0, alpha: 0)
        postButton.setTitle("Post", for: .normal)
        containerView.addSubview(postButton)
        // postButton.isEnabled = false
        postButton.addTarget(self, action: #selector(handelComment), for: .touchUpInside)
        postButton.anchor(top:topBorder.bottomAnchor, leading: self.commentInputField.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 5, bottom: 0, right: 5), size: CGSize(width: 50, height: 40))
        return containerView
    }()
    
    @objc func handleEmojiButton(sender : UIButton){
        print(sender.tag)
        
        self.commentInputField.text = "\(sender.tag)"
        
    }
    
    
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
            self.commentInputField.text = ""
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
