//
//  SharePhotoVC.swift
//  Instagram
//
//  Created by sinbad on 7/12/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoVC: UIViewController {
    
    let shareImageView = UIImageView()
    let shareTextField = UITextField()

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
    
    static let name = NSNotification.Name("setAutomaticFeedHomeVC")
    
    
    @objc func handleShare(){
        
        guard let image = selectedImage else {return}
        
        guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
        
        
        let fileName = NSUUID().uuidString
        
        let storageRef = Storage.storage().reference().child("post_image").child(fileName)
        storageRef.putData(uploadData, metadata: nil) { (metadata, err) in
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                print("Failed to upload profile image:", err)
                return
            }
            // Firebase 5 Update: Must now retrieve downloadURL
            storageRef.downloadURL(completion: { (downloadURL, err) in
                if let err = err {
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                    print("Failed to fetch downloadURL:", err)
                    return
                }
                guard let image = downloadURL?.absoluteString else { return }
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Successfully uploaded profile image:", image)
                
                guard let uid = Auth.auth().currentUser?.uid else { return }
 
                let userPostRef = Database.database().reference().child("posts").child(uid)
                
                let ref = userPostRef.childByAutoId()
                
                guard let caption = self.shareTextField.text else {return}
                guard let postImage = self.selectedImage else {return}
                
                let values = [
                        "imageUrl": image,
                        "caption" : caption,
                        "imageWidth": postImage.size.width,
                        "imageHeight" : postImage.size.height,
                        "createDate" : Date().timeIntervalSince1970
                    ] as [String : Any]
                
                ref.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if let err = err {
                        self.navigationItem.rightBarButtonItem?.isEnabled = false

                        print("Failed to save user info into db:", err)
                        return
                    }
                })
                print("Successfully saved user info to db")
                self.dismiss(animated: true, completion: nil)
                
                NotificationCenter.default.post(name: SharePhotoVC.name, object: nil)
            })
        }
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
