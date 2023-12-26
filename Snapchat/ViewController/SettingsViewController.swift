//
//  SettingsViewController.swift
//  Snapchat
//
//  Created by Ahmet Tunahan Bekdaş on 26.12.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.layer.cornerRadius = logoutButton.frame.size.height/2
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        print("Logout Button Tapped")
    }
    
}
