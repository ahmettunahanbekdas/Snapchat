//
//  ViewController.swift
//  Snapchat
//
//  Created by Ahmet Tunahan Bekdaş on 26.12.2023.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
//MARK: - @IBOutlet and Variables
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = loginButton.frame.size.height/2
        signupButton.layer.cornerRadius = signupButton.frame.size.height/2
        
        passwordTextField.isSecureTextEntry = true
 
    }
    
    //MARK: - signupButtonTapped()
    @IBAction func signupButtonF(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" && usernameTextField.text != "" {
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                }else {
                    let fireStore = Firestore.firestore()
                    let userDictonary = ["email": self.emailTextField.text!,"username": self.usernameTextField.text!] as [String:Any]
                    fireStore.collection("UserInfo").addDocument(data: userDictonary) { error in
                        if error != nil {
                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                        }
                    }
                    self.performSegue(withIdentifier: "tooFeedVC", sender: nil)
                }
            }
        }else{
            self.makeAlert(title: "Error", message: "Please Enter Password/Username/Email")
        }
    }
    
    //MARK: - loginButtonTapped()
    @IBAction func loginButtonF(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authData, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "tooFeedVC", sender: nil)
                }
            }
        } else {
            self.makeAlert(title: "Error", message: "Error")
        }
    }
}


