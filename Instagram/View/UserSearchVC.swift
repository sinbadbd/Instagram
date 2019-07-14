//
//  SearchVC.swift
//  Instagram
//
//  Created by Zahedul Alam on 14/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Firebase
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
    
    func fetchUser(){
        var ref: DatabaseReference!
        ref = Database.database().reference().child("users") 
        ref.observe(.value, with: { (snap) in
            guard let userDictonary = snap.value as? [String : Any] else {return}
            let user = User(dict: userDictonary)
            print("u---\(user)")
        }) { (_) in
            print("could't fetch data!")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SEARCH, for: indexPath) as! UserSearchCell
        //cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
}
