//
//  UIApplication+Extension.swift
//  OwenEthereumWallet
//
//  Created by Carki on 2/17/24.
//

import UIKit

extension UIApplication {
     func dismissKeyboard() {
         sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
    
    func createTabBar(index: Int) {
        let sceneDelegate = connectedScenes.first!.delegate as! SceneDelegate
        let tabBar = TabBarController()
        tabBar.selectedIndex = index
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(tabBar, animated: false)
    }
}
