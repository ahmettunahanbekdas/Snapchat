//
//  FeedViewController.swift
//  Snapchat
//
//  Created by Ahmet Tunahan Bekdaş on 26.12.2023.
//

import UIKit
import Firebase

class FeedViewController: UIViewController {
// MARK: - @IBOutlet and Variables
    @IBOutlet weak var tableView: UITableView!
    
    let fireStoreDatabase = Firestore.firestore()
    var userNameArray = [String]()
    var userEmailArray = [String]()
    var documentIDArray = [String]()
    
// MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
    }
    
    // MARK: - getUserInfo()
    func getUserInfo() {
        fireStoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapShot, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            }else {
                if snapShot?.isEmpty != true {
                    for document in snapShot!.documents {
                        if let userName = document.get("username") as? String {
                            UserSingleton.sharedUserInfo.userName = userName
                        }
                        if let userEmail = document.get("email") as? String {
                            UserSingleton.sharedUserInfo.email = userEmail
                        }
                    }
                }
            }
        }
    }
}

