//
//  SnapViewController.swift
//  Snapchat
//
//  Created by Ahmet Tunahan Bekdaş on 2.01.2024.
//

import UIKit
import ImageSlideshow
import Kingfisher
import ImageSlideshowKingfisher

class SnapViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedSnap: Snap?
    var selectedTimeLeft: Int!
    var inputArray = [KingfisherSource]()
    
    @IBOutlet weak var snapIconImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let snap = selectedSnap {
            for imageUrl in snap.imageUrlArray {
                inputArray.append(KingfisherSource(urlString: imageUrl)!)
            }
            timeLabel.text = "Time Left \(snap.timeDifference) Hour"
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.90))
            let customColor = #colorLiteral(red: 1, green: 0.9878589511, blue: 0.002851458266, alpha: 1)
            
            let indicator = UIPageControl()
            indicator.pageIndicatorTintColor = UIColor.lightGray
            indicator.currentPageIndicatorTintColor = UIColor.systemBlue
            imageSlideShow.pageIndicator = indicator
            imageSlideShow.backgroundColor = customColor
            
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)

            self.view.addSubview(imageSlideShow)
            self.view.bringSubviewToFront(timeLabel) // Önce çıkardık
            self.view.bringSubviewToFront(snapIconImage) // Önce çıkardık

        }
    }
}
