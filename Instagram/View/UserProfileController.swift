//
//  UserProfileController.swift
//  Instagram
//
//   on 10/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Firebase
class UserProfileController: UICollectionViewController {
    
    override func viewDidLoad() {
        collectionView.backgroundColor = .white
        navigationItem.title = Auth.auth().currentUser?.uid
        fetchUser()
    }
    
    func fetchUser() {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        // self.navigationItem.title = Auth.auth().currentUser?.uid
        
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            print(snapshot)
            guard let value = snapshot.value as? [String : Any] else {return}
            let username = value["username"] as? String ?? ""
            // let user = User(username: username)
            print(username)
            self.navigationItem.title = username
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
