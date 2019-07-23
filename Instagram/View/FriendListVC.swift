
//
//  FriendListVC.swift
//  Instagram
//
//  Created by Zahedul Alam on 23/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendListVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        self.collectionView!.register(FriendListCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Firend List"
    }
    // MARK: UICollectionViewDataSource

 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendListCell
    
        // Configure the cell
       // cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chatMessage = ChatMessagesVC()
        navigationController?.pushViewController(chatMessage, animated: true)
    }

}
