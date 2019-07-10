//
//  MainTabBarController.swift
//  Instagram
//
//  Created by Zahedul Alam on 10/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        
        let layout = UICollectionViewFlowLayout()
        
        let profile = UserProfileController(collectionViewLayout: layout)
        
        let navigationController = UINavigationController(rootViewController: profile)
        navigationController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        navigationController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        tabBar.tintColor = .black
        viewControllers = [navigationController]
    }
}
