//
//  HomeVC.swift
//  Instagram
//
//  Created by sinbad on 7/11/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
class HomeVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let HOME_CELL = "HOME_CELL"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor  = .white
        // Do any additional setup after loading the view.
        collectionView.register(HomeViewCell.self, forCellWithReuseIdentifier:  HOME_CELL)
        fetchHomeData() 
    }
    var post = [Posts]()
    
    func fetchHomeData(){
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        Database.fetchUserWithUID(uid: userID) { (user) in
            self.fetchPostsWithUser(user: user)
        }
        
    }
    
    
    func fetchPostsWithUser(user: User){
        var ref: DatabaseReference!
        ref = Database.database().reference().child("posts").child(user.uid)
        
        ref.observe(.value, with: { (snap) in
            guard let userDictonary = snap.value as? [String : Any] else {return}
            let user = User(uid: user.uid, dict: userDictonary)
            
            //  print("user:\(user)")
            ref.queryOrdered(byChild: "createDate").observe(.value, with: { (snap) in
                guard let dictonaries =  snap.value as? [String : Any] else {return}
                //  print(snap.value)
                dictonaries.forEach({ (key, value) in
                    guard let dictionary = value as? [String: Any] else {return}
                    //  var user =  User(dict: ["username" : "imaran"])
                    let post = Posts(user: user, dict: dictionary)
                    self.post.append(post)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                })
            }) { (_) in
                print("Failed to fetch post")
            }
        })
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post.count
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HOME_CELL, for: indexPath) as! HomeViewCell
        cell.post = post[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
