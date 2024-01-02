//
//  FeedViewController.swift
//  Snapchat
//
//  Created by Ahmet Tunahan Bekdaş on 26.12.2023.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - @IBOutlet and Variables
    @IBOutlet weak var tableView: UITableView!
    
    let fireStoreDatabase = Firestore.firestore()
    var userNameArray = [String]()
    var userEmailArray = [String]()
    var documentIDArray = [String]()
    
    var snapArray = [Snap]()
    var chosenSnap: Snap?
    var chosenTimeLeft: Int?
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
        getSnapsData()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    // MARK: - getSnapsData()
    func getSnapsData() {
        fireStoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { snapShot, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            }else {
                if snapShot?.isEmpty == false && snapShot != nil{
                    self.snapArray.removeAll(keepingCapacity: false)
                    for document in snapShot!.documents{
                        let documentId = document.documentID
                        if let userName = document.get("snapOwner") as? String{
                            if let imageUrlArray = document.get("imageUrlArray") as? [String]{
                                if let date = document.get("date") as? Timestamp{
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour{
                                        if difference >= 24 {
                                            self.fireStoreDatabase.collection("Snaps").document(documentId).delete { error in
                                                if error != nil {
                                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                                }
                                                
                                            }
                                        }
                                        self.chosenTimeLeft = 24 - difference
                                        print("İLK ZAMAN ZAMAN ZAMAN \(difference)")
                                    }
                                    let snap = Snap(userName: userName, imageUrlArray: imageUrlArray, date: date.dateValue())
                                    self.snapArray.append(snap)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
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
    
    // MARK: - numberOfRowsInSection()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    // MARK: - cellForRowAt()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.feedUserNameCell.text = snapArray[indexPath.row].userName
        cell.feedImageCell.sd_setImage(with: URL(string: snapArray[indexPath.row].imageUrlArray[0]))
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC"{
            let destinationVC = segue.destination as? SnapViewController
            destinationVC?.selectedSnap = chosenSnap
            destinationVC?.selectedTimeLeft = chosenTimeLeft
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSnap = self.snapArray[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
}

