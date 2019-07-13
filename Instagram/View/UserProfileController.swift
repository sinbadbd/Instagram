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
    
    let HEADER_CELL = "HEADER_CELL"
    let GRIDE_CELL = "GRIDE_CELL"
    
    var user : User?
    
    override func viewDidLoad() {
        collectionView.backgroundColor = .white
        navigationItem.title = Auth.auth().currentUser?.uid
        fetchUser()
        
        collectionView.register(UserProfileCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HEADER_CELL)
        collectionView.register(UserPostImageCell.self, forCellWithReuseIdentifier: GRIDE_CELL)
        
        
        setuplogoutButton()
        
        self.collectionView.reloadData()
        fetchPost()
    }
    
    var post = [Posts]()
    
    func fetchPost(){
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        var ref: DatabaseReference!
        ref = Database.database().reference().child("posts").child(userID)
        ref.observe(.value, with: { (snap) in
        guard let dictonaries =  snap.value as? [String : Any] else {return}
            //  print(snap.value)
            dictonaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else {return}
                let post = Posts(dict: dictionary)
               // let imageUrl = dictionary["imageUrl"] as? String
             //   self.postImag.append(imageUrl)
              //  print("image url\(self.post?.imageUrl)")
                self.post.append(post)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        }) { (_) in
            print("Failed to fetch post")
        }
    }
    
    func setuplogoutButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc func handleLogout(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (_) in
            do {
                try Auth.auth().signOut()
                let loginVC = LoginVC()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(loginVC, animated: true)
                }
            } catch {
                
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HEADER_CELL, for: indexPath)
        // header.backgroundColor = .green
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GRIDE_CELL, for: indexPath) as! UserPostImageCell
        let api = post[indexPath.item]
        let url = URL(string: api.imageUrl!)
         cell.userProfileImage.sd_setImage(with: url, completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
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
