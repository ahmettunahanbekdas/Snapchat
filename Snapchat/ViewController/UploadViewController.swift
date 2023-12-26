//
//  UploadViewController.swift
//  Snapchat
//
//  Created by Ahmet Tunahan Bekdaş on 26.12.2023.
//

import UIKit

class UploadViewController: UIViewController {

    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadButton.layer.cornerRadius = uploadButton.frame.size.height/2
    }
    

    @IBAction func uploadButtonTapped(_ sender: Any) {
    }
    
}
