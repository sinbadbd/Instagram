

import UIKit
import Firebase

class SignupVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let plusButton:UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePhoto(){
        let imagePickerController =  UIImagePickerController()
        imagePickerController.delegate = self
      //  imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print(pickedImage)
            plusButton.setImage(pickedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            plusButton.layer.cornerRadius = plusButton.frame.width / 2
            plusButton.clipsToBounds = true
            plusButton.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            plusButton.layer.borderWidth = 3
            self.dismiss(animated: true, completion: nil)
        }
        
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
    
    
    let userNameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
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
    
    let signupButton :UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSignUpButton(){
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let username = userNameTextField.text ?? ""
        if (email.isEmpty == true || email == "") || (password.isEmpty == true || password == "") || (username.isEmpty == true || username == "") {
           // print("Cant blank", email, password, username)
            alerMessage(title: "Alert!", message: "Can't blank any field!")
        }
        Auth.auth().createUser(withEmail: email, password: password) { (FIRUser, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let image = self.plusButton.imageView?.image else { return }
            
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
            
            let filename = NSUUID().uuidString
            
            let storageRef = Storage.storage().reference().child("profile_images").child(filename)
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, err) in
                
                if let err = err {
                    print("Failed to upload profile image:", err)
                    return
                }
                
                // Firebase 5 Update: Must now retrieve downloadURL
                storageRef.downloadURL(completion: { (downloadURL, err) in
                    if let err = err {
                        print("Failed to fetch downloadURL:", err)
                        return
                    }
                    
                    guard let profileImageUrl = downloadURL?.absoluteString else { return }
                    
                    print("Successfully uploaded profile image:", profileImageUrl)
                    
                    guard let uid = FIRUser?.user.uid else { return }
                    
                    let dictionaryValues = ["username": username, "email":email, "password":password, "profileImageUrl": profileImageUrl]
                    let values = [uid: dictionaryValues]
                    
                    Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                        
                        if let err = err {
                            print("Failed to save user info into db:", err)
                            return
                        }
                        
                        print("Successfully saved user info to db")
                        
                    })
                })
            }) 
            print("Successfully create User!", FIRUser?.user.uid ?? "")
        }
    }

    func alerMessage(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            @unknown default:
                print("")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 80, left: 20, bottom: 0, right: 20), size: CGSize(width: 140, height: 140))
        plusButton.centerXInSuperview()
        
        setupInputFields()
    }
    
    func setupInputFields(){
        let inputView = UIView()
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.backgroundColor = .red
        let stackview = UIStackView(arrangedSubviews: [emailTextField, userNameTextField,passwordTextField,signupButton])
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fillEqually
        stackview.axis = .vertical
        stackview.spacing = 10
        view.addSubview(stackview)
        
        stackview.anchor(top: plusButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor , padding: .init(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 200, height: 250))
        
        
    }
    
    
}

