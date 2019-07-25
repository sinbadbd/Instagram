
//
//  FriendListVC.swift
//  Instagram
//
//  Created by Zahedul Alam on 23/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FriendListVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    
    var user = [User]()
    
    
    
    func showMessageVC(user: User){
        let chatMessage = ChatMessagesVC()
        navigationController?.pushViewController(chatMessage, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        self.collectionView!.register(FriendListCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Friend List"
        
        fetchFollowingFiend()
    }
    func fetchFollowingFiend(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference().child("users")
        ref.observe(.value, with: { (snap) in
            //print(snap)
            guard let dictionary = snap.value as? [String : Any] else { return }
           
            dictionary.forEach({ (key, value) in
                guard let dict = value as? [String: Any] else { return }
                print(dict)
               // print(dictionary)
                let userlist = User(uid: key, dict: dict)
                self.user.append(userlist)
                self.collectionView.reloadData()
                
            })
            
           //
        }) { (err) in
            print(err)
        }
        
    }
    
    
    // MARK: UICollectionViewDataSource

 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
      
        print(user.count)
        return user.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendListCell
      //  indexPath.item < post.count
        if indexPath.item < user.count {
            let apiResponse = user[indexPath.item]
            cell.user = apiResponse
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = self.user[indexPath.item]
        let tex = user.username
       print(user, tex)
        let chatMsg = ChatMessagesVC()
        chatMsg.user = user
        navigationController?.pushViewController(chatMsg, animated: true)
        //self.chatMsg?.showMessageVC(user: user)
    }

}
