//
//  LoginVC.swift
//  Instagram
//
//  Created by Zahedul Alam on 11/7/19.
//  Copyright © 2019 sinbad. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        view.addSubview(signupButton)
        signupButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 40, right: 0))
        // Do any additional setup after loading the view.
        
        setupInputFields()
        self.tabBarController?.tabBar.isHidden = true

    }
    
    let logoView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 63, green: 114, blue: 155)
        return view
    }()
    
    let logoImage : UIImageView = {
        let logo = UIImageView()
        logo.image = #imageLiteral(resourceName: "Instagram_logo_white").withRenderingMode(.alwaysOriginal)
        logo.contentMode = .scaleAspectFill
        return logo
    }()
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
    
    let emailTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.7981644164, green: 0.8406948062, blue: 0.8637670013, alpha: 1)
        textField.font = UIFont.systemFont(ofSize: 14)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        
        
        return textField
    }()
    
    
    
    let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = #colorLiteral(red: 0.7981644164, green: 0.8406948062, blue: 0.8637670013, alpha: 1)
        textField.layer.borderWidth = 1
        textField.font = UIFont.systemFont(ofSize: 14)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        
        return textField
    }()
    
    let signinButton :UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
        return button
    }()

    @objc func handleSignUpButton(){
       let email = emailTextField.text ?? ""
       let password = passwordTextField.text ?? ""
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("Failed to logged in\(error.localizedDescription)")
                return
            }
            print("Successfullty login....", user?.user.uid ?? "")
            
          let profileVC = HomeVC(collectionViewLayout: UICollectionViewFlowLayout())
          //  self.present(profileVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(profileVC, animated: true)
            
            
//            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {  return }
//           mainTabBarController.setupController()
         //  self.dismiss(animated: true, completion: nil)

        }
    }
    
    
    func setupInputFields(){
        
        view.addSubview(logoView)
        logoView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(), size: CGSize(width: logoView.frame.width, height: 150))
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        logoView.addSubview(logoImage)
        logoView.translatesAutoresizingMaskIntoConstraints = false
      //  logoImage.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(),size: CGSize(width: 100, height: 100))
        logoImage.centerInSuperview()
        
        let inputView = UIView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.backgroundColor = .red
        let stackview = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,signinButton])
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fillEqually
        stackview.axis = .vertical
        stackview.spacing = 10
        view.addSubview(stackview)
        
        stackview.anchor(top: logoView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor , padding: .init(top: 40, left: 20, bottom: 0, right: 20), size: CGSize(width: 200, height: 180))
        
        
    }
}
