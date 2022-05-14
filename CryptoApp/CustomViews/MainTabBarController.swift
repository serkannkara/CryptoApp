//
//  MainTabBarController.swift
//  CryptoApp
//
//  Created by Serkan on 6.05.2022.
//

import Foundation
import UIKit


class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        LayoutUI()
        viewControllers = [
            createNavigationController(viewController: CryptoListViewController(), title: "Crypto Coins", imageName: "bitcoinsign.circle"),
            createNavigationController(viewController: NewsListViewController(), title: "Crypto News", imageName: "newspaper"),
        ]
    }
    
    func createNavigationController(viewController: UIViewController, title: String, imageName:String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.view.backgroundColor = .systemBackground
        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        return navController
    }
    
    private func LayoutUI(){
        UITabBar.appearance().backgroundColor = .black.withAlphaComponent(0.85)
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().barStyle = .black
        UINavigationBar.appearance().tintColor           = .white
        UINavigationBar.appearance().barStyle            = .black
        UINavigationBar.appearance().titleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.white ]
    }
}
