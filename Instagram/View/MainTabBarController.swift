//
//  MainTabBarController.swift
//  Instagram
//
//   on 10/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Firebase
class MainTabBarController : UITabBarController , UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
            if index == 2 {
                let layout = UICollectionViewFlowLayout()
                let photoSelectorController = PhotoSelectorVC(collectionViewLayout: layout)
                let navController = UINavigationController(rootViewController: photoSelectorController)
                self.present(navController, animated: true, completion: nil)
                return false
            }
        return true
    }
    
    
    override func viewDidLoad() {
        self.delegate = self
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
        navigationController?.isNavigationBarHidden = true
        
        setupController()
    }
    func setupController() {
        
      //  let homeVC =  setupNavigationVC(selectedImage:  "home_selected", unslectedImage: "home_unselected")
        let homeVC = setupNavigationVC(rootViewController: HomeVC(collectionViewLayout: UICollectionViewFlowLayout()), selectedImage:  "home_selected", unslectedImage: "home_unselected")
        let searchNavController =  setupNavigationVC(selectedImage:  "search_selected", unslectedImage: "search_unselected")
        let plusNavController =  setupNavigationVC(selectedImage:  "plus_selected", unslectedImage: "plus_unselected")
        let likeNavController =  setupNavigationVC(selectedImage:  "like_selected", unslectedImage: "like_unselected")
        
        
 
        let layout = UICollectionViewFlowLayout()
        let profile = UserProfileController(collectionViewLayout: layout)

        let userProfileNavController = UINavigationController(rootViewController: profile)
        userProfileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        userProfileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        tabBar.tintColor = .black
              //  viewControllers = [homeNavController, userProfileNavController]
        
        viewControllers  = [
            homeVC, searchNavController,plusNavController,likeNavController,userProfileNavController
            //  setupNavigationVC(viewController: HomeVC(), title: "Home", imageName: "home")
        ]
        
        //modify tab bar item insets
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        }
    }
    
    func setupNavigationVC(rootViewController: UIViewController = UIViewController(), selectedImage: String, unslectedImage: String) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.title = title
        navController.tabBarItem.selectedImage = UIImage(named: selectedImage)
        navController.tabBarItem.image = UIImage(named: unslectedImage)
        return navController
    }
}
