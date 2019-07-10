//
//  UserProfileController.swift
//  Instagram
//
//   on 10/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        collectionView.backgroundColor = .white
        navigationItem.title = Auth.auth().currentUser?.uid
        fetchUser()
  
        collectionView.register(UserProfileCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HEADER_CELL)
    }
    
    let HEADER_CELL = "HEADER_CELL"
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HEADER_CELL, for: indexPath)
           // header.backgroundColor = .green
            return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    var user : User?
    
    func fetchUser() {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            print(snapshot)
            guard let dictonary = snapshot.value as? [String : Any] else {return}            
            self.user = User(dict: dictonary)
            self.navigationItem.title = self.user?.username
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
