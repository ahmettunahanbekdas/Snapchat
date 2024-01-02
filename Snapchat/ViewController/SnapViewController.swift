//
//  SnapViewController.swift
//  Snapchat
//
//  Created by Ahmet Tunahan Bekdaş on 2.01.2024.
//

import UIKit

class SnapViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedSnap: Snap?
    var selectedTimeLeft: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedTimeLeft)
        timeLabel.text = "Time Left \(selectedTimeLeft!)"

    }
    

}
