//
//  BaseViewController.swift
//  NasaDemo
//
//  Created by Admin on 15.11.2020.
//

import UIKit
import Kingfisher

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return  dateFormatter.string(from: date!)
    }
    
}
