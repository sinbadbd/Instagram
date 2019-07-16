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
    
    var userId : String?
    
    override func viewDidLoad() {
        collectionView.backgroundColor = .white
        //navigationItem.title = Auth.auth().currentUser?.uid
        
        collectionView.register(UserProfileHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HEADER_CELL)
        collectionView.register(UserPostImageCell.self, forCellWithReuseIdentifier: GRIDE_CELL)
        self.collectionView.reloadData()
        
        setuplogoutButton()
        fetchUser()
    }
    
    var post = [Posts]()
    
    func fetchPost(){
    // guard   let userID = userId ?? Auth.auth().currentUser?.uid
        guard let userID = self.user?.uid else {return}
        
        var ref: DatabaseReference!
        ref = Database.database().reference().child("posts").child(userID)
       
        //perhaps later on we'll implement some pagination of data
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            guard let user = self.user else { return }
            
            let post = Posts(user: user, dict: dictionary)
            self.post.insert(post, at: 0)
            
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch ordered posts:", err)
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
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HEADER_CELL, for: indexPath) as! UserProfileHeaderCell
        header.user = self.user
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
        
        let userID = userId ?? Auth.auth().currentUser?.uid ?? ""
        
        Database.fetchUserWithUID(uid: userID) { (user) in
            self.user = user
            self.navigationItem.title = user.username
            self.collectionView?.reloadData()
            self.fetchPost()
        }

    }
}
