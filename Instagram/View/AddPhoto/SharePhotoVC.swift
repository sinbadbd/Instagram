//
//  SharePhotoVC.swift
//  Instagram
//
//  Created by sinbad on 7/12/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

class SharePhotoVC: UIViewController {

    let shareImageView = UIImageView()
    
    var selectedImage : UIImage? {
        didSet {
            self.shareImageView.image = selectedImage
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupUIView()
    }
    @objc func handleShare(){
        
    }
    
    func setupUIView(){
     
        let shareView = UIView()
        let bottomBorderView = UIView()
        
        view.addSubview(shareView)
        shareView.translatesAutoresizingMaskIntoConstraints = false
        shareView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: CGSize(width: shareView.frame.width, height: 80))
        
        view.addSubview(bottomBorderView)
        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        bottomBorderView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        bottomBorderView.anchor(top: nil, leading:view.leadingAnchor, bottom: shareView.bottomAnchor, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: 0, height: 1))
        
    
        shareView.addSubview(shareImageView)
        shareImageView.contentMode = .scaleAspectFit
        shareImageView.clipsToBounds = true
        //shareImageView.backgroundColor = .red
        shareImageView.anchor(top: shareView.topAnchor, leading: shareView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 2, left: 10, bottom: 0, right: 0), size: CGSize(width: 70, height: 70))
        
        
        let shareTextField = UITextField()
        shareView.addSubview(shareTextField)
        shareTextField.translatesAutoresizingMaskIntoConstraints = false
        shareTextField.placeholder = "Write a caption..."
        shareTextField.anchor(top: shareView.topAnchor, leading: shareImageView.trailingAnchor, bottom: nil, trailing: shareView.trailingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 0), size: CGSize(width: shareTextField.frame.width, height: shareTextField.frame.height))
        shareTextField.centerYInSuperview()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
