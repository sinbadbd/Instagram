//
//  UserProfileCell.swift
//  Instagram
//
//  on 10/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class UserProfileCell: UICollectionViewCell {
    
    let userProfileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 80 / 2
        image.clipsToBounds = true
        return image
    }()
    
    let listButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid").withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.1)
        //button.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
        return button
    }()
    let grideButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list").withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.1)
        // button.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
        return button
    }()
    
    let bookmarkButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon").withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.1)
        //  button.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
        return button
    }()
    
    let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let pastLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        let font = UIFont.boldSystemFont(ofSize: 14)
        
      //  let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        //attributedText.append(NSAttributedString(string: "posts", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
       // label.attributedText = attributedText
        label.textAlignment = .center
        return label
    }()
    let followersLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        let font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    let followingLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        let font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    
    
    let postsTextLabel : UILabel = {
        let label = UILabel()
        label.text = "Posts"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    let followersTextLabel : UILabel = {
        let label = UILabel()
        label.text = "Followers"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    let followingTextLabel : UILabel = {
        let label = UILabel()
        label.text = "Following"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.textAlignment = .center
        return label
    }()
 
    let topBorderView : UIView = UIView()
    let bottomBorderView : UIView = UIView()
    
    let editProfileButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 4
        //button.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userProfileImage)
        userProfileImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: CGSize(width: 80, height: 80))
        addSubview(usernameLabel)
        usernameLabel.anchor(top: userProfileImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 30, bottom: 0, right: 10), size: CGSize(width: 50, height: usernameLabel.frame.height))
    
        
        setupProfileTools()
        fetchUserProfile()
        setupBottomToolBar()
    }
    func setupProfileTools(){
        let stackview = UIStackView(arrangedSubviews: [pastLabel,followersLabel,followingLabel])
        
        addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        stackview.anchor(top: topAnchor, leading: userProfileImage.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 20))
        
        let stackviewProfile = UIStackView(arrangedSubviews: [postsTextLabel,followersTextLabel,followingTextLabel])
        
        addSubview(stackviewProfile)
        stackviewProfile.translatesAutoresizingMaskIntoConstraints = false
        stackviewProfile.distribution = .fillEqually
        stackviewProfile.axis = .horizontal
        stackviewProfile.alignment = .center
        stackviewProfile.anchor(top: stackview.bottomAnchor, leading: userProfileImage.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 20))
        
        
        
        addSubview(editProfileButton)
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.anchor(top: stackviewProfile.bottomAnchor, leading: usernameLabel.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20), size: CGSize(width: 80, height: 40))
    }
    func setupBottomToolBar(){
        let stackview = UIStackView(arrangedSubviews: [listButton,grideButton,bookmarkButton])
        
        addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fillProportionally
        stackview.axis = .horizontal
        stackview.anchor(top: userProfileImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 60, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        
        
        
        addSubview(topBorderView)
        topBorderView.translatesAutoresizingMaskIntoConstraints = false
        topBorderView.anchor(top: stackview.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: CGSize(width: topBorderView.frame.width, height: 0.5))
        topBorderView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        addSubview(bottomBorderView)
        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        bottomBorderView.anchor(top: stackview.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: CGSize(width: topBorderView.frame.width, height: 0.5))
        bottomBorderView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

    }
    
    
    var user : User?
    
    func fetchUserProfile() {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            print(snapshot)
            guard let dictonary = snapshot.value as? [String : Any] else {return}
            
            let imageURL = dictonary["profileImageUrl"] as? String ?? "" 
            let user = User(dict: dictonary)
            self.userProfileImage.sd_setImage(with: URL(string: user.profileImage), placeholderImage: #imageLiteral(resourceName: "plus_photo"))
            self.usernameLabel.text = user.username
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
