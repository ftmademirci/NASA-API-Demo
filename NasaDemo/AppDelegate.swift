//
//  AppDelegate.swift
//  NasaDemo
//
//  Created by Admin on 14.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabBarController = CustomTabbarController()
        var tabs = [UIViewController]()
        
        tabBarController.tabBar.barStyle = .black
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.isTranslucent = false
        
        for roverType in RoverTypes.allCases {

            let tabViewController = MainViewController(nibName: "MainViewController", bundle: nil)
            tabViewController.roverType = roverType

            tabViewController.tabBarItem = UITabBarItem(
                title: roverType.rawValue,
                image: UIImage(named: "rover_\(roverType)"),
                tag: 1)
            
            tabs.append(tabViewController)

        }
                
        tabBarController.viewControllers = tabs
        
        tabBarController.title = "NASA"
        
        let navigationController = UINavigationController(rootViewController: tabBarController)
        
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.tintColor = .white

        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    
    
    
}

