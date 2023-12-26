//
//  ViewController.swift
//  Snapchat
//
//  Created by Ahmet Tunahan Bekdaş on 26.12.2023.
//

import UIKit
import Firebase
import FirebaseCore

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = loginButton.frame.size.height/2
        
        signupButton.layer.cornerRadius = signupButton.frame.size.height/2
    }

 
    @IBAction func loginButtonF(_ sender: Any) {
        print("LogIn")
        performSegue(withIdentifier: "tooFeedVC", sender: nil)
    }
    
    @IBAction func signupButtonF(_ sender: Any) {
        print("SignUp")
    }
}

