//
//  MainTabViewController.swift
//  Union
//
//  Created by Камилла Буланова on 08.11.2021.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    private let mapViewController = MapViewController()
    private let settingsViewController = SettingsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        
        tabBar.isTranslucent = false
        
        let mapNavigationVC = UINavigationController(rootViewController: mapViewController)
        mapNavigationVC.tabBarItem = UITabBarItem(title: "Карта",
                                                    image: #imageLiteral(resourceName: "map"),
                                                    tag: 0)
        let settingsNavigationVC = UINavigationController(rootViewController: settingsViewController)
        settingsNavigationVC.tabBarItem = UITabBarItem(title: "Настройки",
                                                       image: #imageLiteral(resourceName: "settings"),
                                                       tag: 1)
        
        viewControllers = [mapNavigationVC, settingsNavigationVC]
    }
}
