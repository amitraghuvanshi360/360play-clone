//
//  CardViewController.swift
//  360play clone
//
//  Created by Ankush Sharma on 30/03/23.
//

import Foundation
import UIKit

class CardViewController: UIViewController{
    
    @IBOutlet weak var searchView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.layer.borderWidth = 0.5
        searchView.layer.borderColor = UIColor.gray.cgColor
    }
}
