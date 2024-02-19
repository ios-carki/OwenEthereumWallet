//   Created on 2024/02/14
//   Using Swift 5.0
//   TabBarController.swift
//   Created by Owen

import UIKit
import SwiftUI

final class TabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupTabBar()
    }
    
    private func setupTabBar(){
        tabBar.tintColor = UIColor(Color.red)
        tabBar.unselectedItemTintColor = UIColor(Color.black)
        tabBar.backgroundColor = UIColor(Color.white)
        tabBar.isTranslucent = true
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color.white)
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
        
        let tabBarItem1 = tabBar.items![0] as UITabBarItem
        let tabBarItem2 = tabBar.items![1] as UITabBarItem
        let tabBarItem3 = tabBar.items![2] as UITabBarItem

        tabBarItem1.selectedImage = UIImage(systemName: "person")
        tabBarItem2.selectedImage = UIImage(systemName: "globe")
        tabBarItem3.selectedImage = UIImage(systemName: "trash")

        tabBarItem1.title = "Wallet"
        tabBarItem2.title = "NFT"
        tabBarItem3.title = "Info"
    }
    
    private func setupVC() {
        viewControllers = [
            create1(image: UIImage(systemName: "person")!),
            create2(image: UIImage(systemName: "globe")!),
            create3(image: UIImage(systemName: "trash")!)
        ]
    }
    
    private func create1(image: UIImage) -> UIViewController {
        let navController = CustomNavigationController()
        let hostingController = UIHostingController(rootView: WalletView(navigation: navController))
        navController.tabBarItem.title = nil
        //navController.tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        navController.tabBarItem.image = image
        //navController.navigationItem.titleView?.tintColor = .black
        navController.navigationBar.prefersLargeTitles = false
        //navController.navigationItem.title = "Wallet"
        navController.pushViewController(hostingController, animated: true)
        return navController
    }
    
    private func create2(image: UIImage) -> UIViewController {
        let navController = CustomNavigationController()
        let hostingController = UIHostingController(rootView: SendView(navigation: navController))
        navController.tabBarItem.title = nil
        //navController.tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        navController.tabBarItem.image = image
        //navController.navigationItem.titleView?.tintColor = .black
        navController.navigationBar.prefersLargeTitles = false
        //navController.navigationItem.title = "Wallet"
        navController.pushViewController(hostingController, animated: true)
        return navController
    }
    
    private func create3(image: UIImage) -> UIViewController {
        let navController = CustomNavigationController()
        let hostingController = UIHostingController(rootView: SettingView(navigation: navController))
        navController.tabBarItem.title = nil
        //navController.tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        navController.tabBarItem.image = image
        //navController.navigationItem.titleView?.tintColor = .black
        navController.navigationBar.prefersLargeTitles = false
        //navController.navigationItem.title = "Wallet"
        navController.pushViewController(hostingController, animated: true)
        return navController
    }
}
