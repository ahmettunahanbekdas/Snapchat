//
//  UploadViewController.swift
//  Snapchat
//
//  Created by Ahmet Tunahan Bekdaş on 26.12.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore


class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - @IBOutlet and Variables
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadButton.layer.cornerRadius = uploadButton.frame.size.height/2
        
        let tapImage = UITapGestureRecognizer.init(target: self, action: #selector(tapImage))
        uploadImage.addGestureRecognizer(tapImage)
        uploadImage.isUserInteractionEnabled = true
    }
    
    // MARK: - uploadButtonTapped()
    @IBAction func uploadButtonTapped(_ sender: Any) {
        // Storage
        let storage = Storage.storage()
        let storagefeReferance = storage.reference()
        
        if let data = uploadImage.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let mediaFolder = storagefeReferance.child("media")
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            
            imageReferance.putData(data, metadata: nil) { metaData, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                }else {
                    imageReferance.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            // Firestore
                            let fireStore = Firestore.firestore()
                            fireStore.collection("Snaps").whereField("snapOwner", isEqualTo: UserSingleton.sharedUserInfo.userName!).getDocuments { snapShot, error in
                                if error != nil {
                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                }else {
                                    if snapShot?.isEmpty == false && snapShot != nil {
                                        for document in snapShot!.documents{
                                            let documentID = document.documentID
                                            if var imageUrlArray = document.get("imageUrlArray") as? [String]{
                                                imageUrlArray.append(imageUrl!)
                                                let additionalDictonary = ["imageUrlArray": imageUrlArray] as [String: Any]
                                                fireStore.collection("Snaps").document(documentID).setData(additionalDictonary, merge: true) { error in
                                                    if error == nil {
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.uploadImage.image = UIImage(named: "addPhoto")
                                                        self.makeAlert(title: "Succes", message: "Shared Your Second Photo ✌🏻")
                                                    }else {
                                                        self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")

                                                    }
                                                }
                                            }
                                        }
                                    } else {
                                        let snapDictonary = ["imageUrlArray": [imageUrl!], "snapOwner": UserSingleton.sharedUserInfo.userName!, "date": FieldValue.serverTimestamp()] as [String:Any]
                                        fireStore.collection("Snaps").addDocument(data: snapDictonary) { error in
                                            if error != nil {
                                                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                            } else {
                                                self.makeAlert(title: "Succes", message: "Shared Your First Photo ✌🏻")
                                                self.tabBarController?.selectedIndex = 0
                                                self.uploadImage.image = UIImage(named: "addPhoto")
                                                print("Snapshot is empty: \(snapShot?.isEmpty ?? true)")
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
            
        }
    }
    
    @objc func tapImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickerImage = info[.editedImage] as? UIImage {
            uploadImage.image = pickerImage
        }
        self.dismiss(animated: true)
    }
}
