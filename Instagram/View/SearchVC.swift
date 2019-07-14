//
//  SearchVC.swift
//  Instagram
//
//  Created by Zahedul Alam on 14/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class SearchVC : UICollectionViewController, UISearchBarDelegate {
    
    fileprivate let searchBarController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .red
        setupSearchController()
    }
    fileprivate func setupSearchController() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBarController.dimsBackgroundDuringPresentation = false
        searchBarController.searchBar.delegate = self
    }
    
}
