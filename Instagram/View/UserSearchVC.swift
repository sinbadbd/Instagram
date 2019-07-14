//
//  SearchVC.swift
//  Instagram
//
//  Created by Zahedul Alam on 14/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
class UserSearchVC : UICollectionViewController, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    let SEARCH = "search_id"
    fileprivate let searchBarController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        setupSearchController()
        
        collectionView.register(UserSearchCell.self, forCellWithReuseIdentifier:  SEARCH )
    }
    fileprivate func setupSearchController() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBarController.dimsBackgroundDuringPresentation = false
        searchBarController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchUser()
    }
    var user = [User]()
    func fetchUser(){
        var ref: DatabaseReference!
        ref = Database.database().reference().child("users")
        ref.observe(.value, with: { (snap) in
            guard let userDictonaries = snap.value as? [String : Any] else {return}
         //   let user = User(dict: userDictonaries)
            userDictonaries.forEach({ (key, value) in
                guard let userDic = value as? [String : Any] else {return}
                
                let user = User(dict: userDic)
                self.user.append(user)
            })
            
            self.collectionView.reloadData()
        }) { (_) in
            print("could't fetch data!")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SEARCH, for: indexPath) as! UserSearchCell
        let api = user[indexPath.item]
        cell.usernameLabel.text  = api.username
        
        let prifileUrl = URL(string: api.profileImage)
        cell.profileImageView.sd_setImage(with: prifileUrl, completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
}
