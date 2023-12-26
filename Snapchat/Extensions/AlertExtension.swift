//
//  AlertExtension.swift
//  Snapchat
//
//  Created by Ahmet Tunahan Bekdaş on 26.12.2023.
//

import UIKit

extension UIViewController {
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
