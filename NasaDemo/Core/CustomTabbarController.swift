//
//  CustomTabbarController.swift
//  NasaDemo
//
//  Created by Admin on 16.11.2020.
//

import UIKit

class CustomTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let navItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(self.filter))
        navItem.tintColor = .white
        self.navigationItem.setRightBarButton(navItem, animated: false)
    }

    @objc func filter() {
        (self.selectedViewController as! MainViewController).filter()
    }

}
