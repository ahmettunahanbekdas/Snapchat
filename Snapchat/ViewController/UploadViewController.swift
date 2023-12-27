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

    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadButton.layer.cornerRadius = uploadButton.frame.size.height/2
        
        let tapImage = UITapGestureRecognizer.init(target: self, action: #selector(tapImage))
        uploadImage.addGestureRecognizer(tapImage)
        uploadImage.isUserInteractionEnabled = true
    }

    @IBAction func uploadButtonTapped(_ sender: Any) {
        let storage = Storage.storage()
        let storafeReferance = storage.reference()
        
        let mediaFolder = storafeReferance.child("media")
        
        if let data = uploadImage.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data, metadata: nil) { metaData, error in
                if error != nil {
                    self.makeAlert(title: "Resim dönüştürülüp dataya ekleniyor", message: error?.localizedDescription ?? "Error")
                }else {
                    imageReferance.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            let fireStore = Firestore.firestore()
                            let snapDictonary = ["imageUrl": imageUrl!, "snapOwner": UserSingleton.sharedUserInfo.userName!, "date": FieldValue.serverTimestamp()] as [String:Any]
                            fireStore.collection("Snaps").addDocument(data: snapDictonary) { error in
                                if error != nil {
                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                } else {
                                    self.makeAlert(title: "Succes", message: "Shared Your Photo ✌🏻")
                                    self.tabBarController?.selectedIndex = 0
                                    self.uploadImage.image = UIImage(named: "addPhoto")
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
