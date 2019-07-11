//
//  MainTabBarController.swift
//  Instagram
//
//   on 10/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Firebase
class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        
        let loginVC = LoginVC()
        
        if Auth.auth().currentUser == nil {
            // User is signed in.
            // ...
            DispatchQueue.main.async {
                let navigationController = UINavigationController(rootViewController: loginVC)
                self.present(navigationController, animated: true, completion: nil)
            }
        } else {
            // No user is signed in.
            // ...
        }
        
       setupController()
    }
    func setupController() {
        navigationController?.isNavigationBarHidden = true
        
        let layout = UICollectionViewFlowLayout()
        let profile = UserProfileController(collectionViewLayout: layout)
        
        let navigationController = UINavigationController(rootViewController: profile)
        navigationController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        navigationController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        tabBar.tintColor = .black
        viewControllers = [navigationController]
    }
}
