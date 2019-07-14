//
//  SearchVC.swift
//  Instagram
//
//  Created by Zahedul Alam on 14/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class SearchVC : UICollectionViewController, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    let SEARCH = "search_id"
    fileprivate let searchBarController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        setupSearchController()
        
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier:  SEARCH )
    }
    fileprivate func setupSearchController() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBarController.dimsBackgroundDuringPresentation = false
        searchBarController.searchBar.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SEARCH, for: indexPath) as! SearchCell
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
}
