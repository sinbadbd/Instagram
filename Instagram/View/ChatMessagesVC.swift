//
//  ChatMessages.swift
//  Instagram
//
//  Created by sinbad on 7/20/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Firebase

class ChatMessagesVC: UITableViewController {
    
    let CELL = "CELL"
    //var commentsIcon = ["😀", "😍", "😛", "🙌","❤️","🔥","🙊","🍎"]
    
    let userProfileCommnetImg = UIImageView()
    let postButton = UIButton(type: .system)
    
    let commentInputField : UITextField = {
        let InputField = UITextField()
        InputField.placeholder = "Send message..."
        return InputField
    }()
    
    let textMessage = [
        ChatMessages(message: "Structs", isIncoming: true),
        ChatMessages(message: "Structs are complex", isIncoming: false),
        ChatMessages(message: "Structs are complex data types, meaning that they are made up of multiple values", isIncoming: true),
        ChatMessages(message: "Structs are complex data types", isIncoming: false),
        ChatMessages(message: "meaning that they are made up of multiple values", isIncoming: true),
        ChatMessages(message: "complex data types", isIncoming: false),
        ChatMessages(message: "meaning that they are made ....", isIncoming: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Message"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: CELL)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 240, green: 240, blue: 240, alpha: 1)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textMessage.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL, for: indexPath) as! ChatMessageCell
        let data = textMessage[indexPath.row]
        cell.selectionStyle = .none
        cell.chatMessage = data
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accept = UIContextualAction(style: .normal, title: "Accept") { (action, view, nil) in
            print("Accept")
        }
        accept.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        let wishList = UIContextualAction(style: .normal, title: "Wishlist") { (action, view, nil) in
            print("Wishlist")
        }
        wishList.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        return UISwipeActionsConfiguration(actions: [accept, wishList])
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            print("Delete")
        }
        delete.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        let rejected = UIContextualAction(style: .destructive, title: "Reject") { (action, view, nil) in
            print("Reject")
        }
        rejected.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return UISwipeActionsConfiguration(actions: [delete, rejected])
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rotationTransForm = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotationTransForm
        UIView.animate(withDuration: 1.0) {
            cell.layer.transform =  CATransform3DIdentity
        }
    }
    
    
    lazy var containerView : UIView = {
        
        let topBorder = UIView()
        topBorder.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        topBorder.layer.borderWidth = 1
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let commentsEmojiView = UIView()
        containerView.addSubview(commentsEmojiView)
        commentsEmojiView.anchor(top: nil, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(), size: CGSize(width: 100, height: 40))
        commentsEmojiView.backgroundColor = .white
        
        
        //commentsIcon
        containerView.addSubview(topBorder)
        topBorder.anchor(top: commentsEmojiView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 0.5))
        
        // userProfileCommnetImg.backgroundColor = .red
        //        containerView.addSubview(userProfileCommnetImg)
        //        userProfileCommnetImg.anchor(top: topBorder.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: CGSize(width: 40, height: 40))
        //        // userProfileCommnetImg.roundedImage()
        //        userProfileCommnetImg.layer.cornerRadius = 40 / 2
        //        userProfileCommnetImg.clipsToBounds = true
        //        userProfileCommnetImg.image = #imageLiteral(resourceName: "user")
        //        userProfileCommnetImg.contentMode = .scaleAspectFill
        
        
        // commentInputField.backgroundColor = .red
        containerView.addSubview(self.commentInputField)
        self.commentInputField.anchor(top: topBorder.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 10, left: 40, bottom: 0, right: 40), size: CGSize(width: 340, height: 40))
        // commentInputField.backgroundColor = .red
        commentInputField.layer.borderWidth = 0.5
        commentInputField.layer.cornerRadius = 12
        commentInputField.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: commentInputField.frame.height))
        commentInputField.leftView = paddingView
        commentInputField.leftViewMode = UITextField.ViewMode.always
        
        
        postButton.backgroundColor = UIColor(white: 0, alpha: 0)
        postButton.setTitle("Send", for: .normal)
        containerView.addSubview(postButton)
        // postButton.isEnabled = false
        postButton.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        postButton.anchor(top:containerView.topAnchor, leading: nil, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 5), size: CGSize(width: 50, height: 40))
        return containerView
    }()
    
    @objc func handleEmojiButton(sender : UIButton){
        //  print(sender.tag)
        print("hi")
        
        //    self.commentInputField.text = commentsIcon[sender.tag]
        
    }
    
    
    @objc func handleSendMessage(){
        print("hi")
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let value = [
            "message" : commentInputField.text ?? "",
            "creationDate" : Date().timeIntervalSince1970,
            "uid" : uid, 
            "isIncoming" : true
            ] as [String : Any]
        
        
        Database.database().reference().child("message").child(uid).updateChildValues(value){ (err, ref) in
            if err != nil {
                return
            }
            self.commentInputField.text = ""
            print("successfully insert send message")
            
            
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
