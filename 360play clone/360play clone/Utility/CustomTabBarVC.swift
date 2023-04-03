//
//  CustomTabBarVC.swift
//  360play clone
//
//  Created by Ankush Sharma on 28/03/23.
//

import Foundation
import UIKit

class CustomTabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        UITabBar.appearance().barTintColor = UIColor.white
    }
}
