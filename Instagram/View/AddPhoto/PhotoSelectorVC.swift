//
//  PhotoSelectorVC.swift
//  Instagram
//
//  Created by sinbad on 7/12/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Photos
class PhotoSelectorVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let reuseIdentifier = "Cell"
    private let reuseIndentifierHeader = "reuseIndentifierHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIndentifierHeader)
        self.collectionView!.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: reuseIdentifier)
       
        setupButtons()
        fetchPhotos()
        // Do any additional setup after loading the view.
    }
 
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var images = [UIImage]()
    func fetchPhotos(){
        let fetchPhotos = PHFetchOptions()
        fetchPhotos.fetchLimit = 10
        let sortDescriptions = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchPhotos.sortDescriptors = [sortDescriptions]
        
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchPhotos)
        
        allPhotos.enumerateObjects { (asset, count, stop) in
            print(asset)
            let imageManager = PHImageManager.default()
            let targetSize = CGSize(width: 300, height: 300)
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
               // print(image)
                if let image = image {
                    self.images.append(image)
                }
            })
            
            if count == allPhotos.count - 1 {
                self.collectionView.reloadData()
            }
            
            
        }
        
    }
    
    func setupButtons (){
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }
    @objc func handleNext(){
        print("next")
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
 
    // HeaderSection
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIndentifierHeader, for: indexPath)
        
        cell.backgroundColor = .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height:400)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoSelectorCell
        let img = images[indexPath.item]
        cell.photoImageView.image = img
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
