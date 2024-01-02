//
//  FeedCell.swift
//  Snapchat
//
//  Created by Ahmet Tunahan Bekdaş on 2.01.2024.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var feedImageCell: UIImageView!
    @IBOutlet weak var feedUserNameCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
