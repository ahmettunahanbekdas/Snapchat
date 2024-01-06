//
//  SettingsViewController.swift
//  Snapchat
//
//  Created by Ahmet Tunahan Bekdaş on 26.12.2023.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.layer.cornerRadius = logoutButton.frame.size.height/2
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        print("Logout Button Tapped")
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "tooSignInVC", sender: nil)
        }catch let signOutError as NSError {
            self.makeAlert(title: "Error", message: "\(signOutError.localizedDescription)")
        }
    }
    
}
