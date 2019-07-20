//
//  ChatMessageCell.swift
//  Instagram
//
//  Created by sinbad on 7/20/19.
//  Copyright © 2019 sinbad. All rights reserved.
//


import UIKit

class ChatMessageCell: UITableViewCell {
    
    let messageLabel = UILabel()
    var bubbleBackgrounView = UIView()
    var leadingConstrain : NSLayoutConstraint!
    var tralingConstrain : NSLayoutConstraint!
    
    var chatMessage : ChatMessages! {
        didSet {
            bubbleBackgrounView.backgroundColor = chatMessage.isIncoming ? .white : #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            messageLabel.text = chatMessage.message
            messageLabel.textColor = chatMessage.isIncoming ? .black : .white
            
            if chatMessage.isIncoming {
                leadingConstrain.isActive = true
                tralingConstrain.isActive = false
            } else {
                leadingConstrain.isActive = false
                tralingConstrain.isActive = true
            }
        }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubview(bubbleBackgrounView)
        bubbleBackgrounView.translatesAutoresizingMaskIntoConstraints = false
        bubbleBackgrounView.layer.cornerRadius = 12
        bubbleBackgrounView.backgroundColor = .red
        
        addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = "Closures can capture and store references to any constants and variables from the context in which they are defined"
        messageLabel.numberOfLines = 0
        
        
        
        
        let constrain = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            bubbleBackgrounView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            bubbleBackgrounView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            bubbleBackgrounView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
            bubbleBackgrounView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            ]
        
        NSLayoutConstraint.activate(constrain)
        
        leadingConstrain =  messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstrain.isActive = false
        tralingConstrain = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        leadingConstrain.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
