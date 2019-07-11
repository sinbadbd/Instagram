//
//  LoginVC.swift
//  Instagram
//
//  Created by Zahedul Alam on 11/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    let signupButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? sign up.", for: .normal)
     //   button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
    }()
    @objc func handleSignup(){
        let signupVC = SignupVC()
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        view.addSubview(signupButton)
        signupButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 80, right: 0))
        // Do any additional setup after loading the view.
    }

}
