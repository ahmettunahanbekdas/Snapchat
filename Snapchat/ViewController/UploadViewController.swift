//
//  UploadViewController.swift
//  Snapchat
//
//  Created by Ahmet Tunahan Bekdaş on 26.12.2023.
//

import UIKit

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
