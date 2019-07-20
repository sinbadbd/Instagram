//
//  ChatMessages.swift
//  Instagram
//
//  Created by sinbad on 7/20/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

class ChatMessagesVC: UITableViewController {
    
    let CELL = "CELL"
    
    
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
        var data = textMessage[indexPath.row]
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
}
