//
//  DetailViewController.swift
//  NasaDemo
//
//  Created by Admin on 16.11.2020.
//

import UIKit

class DetailViewController: BaseViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var photoDateLabel: UILabel!
    @IBOutlet var roverNameLabel: UILabel!
    @IBOutlet var cameraNameLabel: UILabel!
    @IBOutlet var roverStatusLabel: UILabel!
    @IBOutlet var roverLaunchDateLabel: UILabel!
    @IBOutlet var roverLandingDateLabel: UILabel!
        
    var detailContent: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = detailContent.img_src ?? ""
        let resourceUrl = URL(string: url)!
        self.imageView.kf.setImage(with: resourceUrl)
        
        let earthDate = detailContent.earth_date
        if let _ = earthDate {
            self.photoDateLabel.text = "Earth Date: " + "\(self.convertDateFormater(earthDate!))"
        }
        
        self.roverNameLabel.text = "Rover Name: " + "\(detailContent.rover?.name ?? "")"
        self.cameraNameLabel.text = "Camera Name: " + "\(detailContent.camera?.name ?? "")"
        self.roverStatusLabel.text = "Rover Status: " + "\(detailContent.rover?.status ?? "")"
        
        let launchDate = detailContent.rover?.launch_date
        if let _ = launchDate {
            self.roverLaunchDateLabel.text = "Launch Date: " + "\(self.convertDateFormater(launchDate!))"
        }
        
        let landingDate = detailContent.earth_date
        if let _ = landingDate {
            self.roverLandingDateLabel.text = "Landing Date: " + "\(self.convertDateFormater(landingDate!))"
        }
    }
    
    @IBAction func exitButtonDidTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
