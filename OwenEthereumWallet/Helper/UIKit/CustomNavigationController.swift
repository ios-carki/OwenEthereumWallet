//   Created on 2024/02/14
//   Using Swift 5.0
//   CustomNavigationController.swift
//   Created by Owen

import UIKit
import SwiftUI

class CustomNavigationController: UINavigationController,UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationController?.navigationBar.tintColor = .white
        viewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
        viewController.navigationItem.titleView?.tintColor = .white
        
        let backButton = BackBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backButton
        
        if var textAttributes = viewController.navigationController?.navigationBar.titleTextAttributes {
            textAttributes[NSAttributedString.Key.foregroundColor] = UIColor.white
            viewController.navigationController?.navigationBar.titleTextAttributes = textAttributes
        }
    }
}

class BackBarButtonItem: UIBarButtonItem {
  @available(iOS 14.0, *)
  override var menu: UIMenu? {
    set {
        
    }
    get {
      return super.menu
    }
  }
}
