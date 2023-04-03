//
//  Constant.swift
//  360play clone
//
//  Created by Ankush Sharma on 29/03/23.
//

import Foundation
import UIKit

struct Constant{
    static let BASE_URL = "https://ops.360-play.me"
    static let EnterEmail = "Please Enter Your Valid Email"
    static let EnteredWrongEmail = "Entered email is wrong"
    static let EnterPassword = "Please Enter Your Password"
    static let EnteredWrongPassword = "Entered password is wrong"
    static let SHORT_PASSWORD = "Your password is length is too short"
    static let ERROR = "ERROR"
    static let OK = "OK"
    static let DONE = "Done"
    static let Delete = "Delete"
    
}

struct AlertController{
    static func ALERT_MESSAGE(title: String , message:String , viewController: UIViewController){
    
        let alert = UIAlertController(title: title , message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
    
    
}
