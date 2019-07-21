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

class HomeVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomePostCellDelegate {
  
    
    
    let HOME_CELL = "HOME_CELL"
    var post = [Posts]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor  = .white
        // Do any additional setup after loading the view.
        collectionView.register(HomeViewCell.self, forCellWithReuseIdentifier:  HOME_CELL)
        
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControll
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdatefeed), name: SharePhotoVC.name, object: nil)
        
        fetchAllPosts() 
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "comment"), style: .plain, target: self, action: #selector(handleChatMessage))
    }
    @objc func handleChatMessage(){
        print("hi")
        let chatMessage = ChatMessagesVC()
        navigationController?.pushViewController(chatMessage, animated: true)
    }
    
    func didTapComment(post: Posts) {
        print("\(post)")
        let commentVC = CommentPostVC(collectionViewLayout: UICollectionViewFlowLayout())
        commentVC.post = post
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    
    func didLike(for cell: HomeViewCell) {
        
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        var post = self.post[indexPath.item]
        
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let postId = post.postId else { return }
        
        let values = [uid: post.hasLike == true ? 0 : 1]
        Database.database().reference().child("likes").child(postId).updateChildValues(values) { (err, ref) in
            if err != nil{
                return
            }
            print("Successfully liked post.")
            
            post.hasLike = !post.hasLike
            self.post[indexPath.item] = post
            self.collectionView?.reloadItems(at: [indexPath])
        }
    }
    
    @objc func handleUpdatefeed(){
        handleRefresh()
    }
    
    @objc func handleRefresh(){
        post.removeAll()
        fetchAllPosts()
    }
    func fetchAllPosts(){
        fetchHomeData()
        fetchFollowingUserIDs()
    }
    
    func fetchFollowingUserIDs(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child("following").child(uid)
            .observeSingleEvent(of: .value, with: { (snap) in
                guard let userIdsDictionary = snap.value as? [String: Any]  else { return }
                userIdsDictionary.forEach({ (key, value) in
                    Database.fetchUserWithUID(uid: key, completion: { (user) in
                        self.fetchPostsWithUser(user: user)
                    })
                })
            }) { (err) in
                print(err)
        }
    }
    
    func fetchHomeData(){
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        Database.fetchUserWithUID(uid: userID) { (user) in
            self.fetchPostsWithUser(user: user)
        }
        
    }
    fileprivate func fetchPostsWithUser(user: User) {
        let ref = Database.database().reference().child("posts").child(user.uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            self.collectionView.refreshControl?.endRefreshing()
            
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                
                var post = Posts(user: user, dict: dictionary)
                post.postId = key
                
                guard let uid = Auth.auth().currentUser?.uid else { return }
                Database.database().reference().child("likes").child(key).child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    print(snapshot)
                    
                    if let value = snapshot.value as? Int, value == 1 {
                        post.hasLike = true
                    } else {
                        post.hasLike = false
                    }
                    self.post.append(post)
                    self.post.sort(by: { (p1, p2) -> Bool in
                        return p1.createDate.compare(p2.createDate) == .orderedDescending
                    })
                    self.collectionView?.reloadData()
                    
                }, withCancel: { (err) in
                    print("Failed to fetch like info for post:", err)
                })
               
            })
            
        }) { (err) in
            print("Failed to fetch posts:", err)
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post.count
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HOME_CELL, for: indexPath) as! HomeViewCell
       
        if indexPath.item < post.count {
            cell.post = post[indexPath.item]
        }

        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
