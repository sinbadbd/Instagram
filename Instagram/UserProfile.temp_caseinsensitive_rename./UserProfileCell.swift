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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userProfileImage)
        userProfileImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: CGSize(width: 80, height: 80))
        
       fetchUserProfile()
    }
    
    func fetchUserProfile() {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            print(snapshot)
            guard let value = snapshot.value as? [String : Any] else {return}
            let imageURL = value["profileImageUrl"] as? String ?? ""
            print(imageURL)
            self.userProfileImage.sd_setImage(with: URL(string: imageURL), placeholderImage: #imageLiteral(resourceName: "capture_photo"))
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
