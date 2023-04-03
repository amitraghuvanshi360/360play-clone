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
    static let enterValidEmail = "Please Enter Your Valid Email"
    static let enteredWrongEmail = "Entered email is wrong"
    static let enterEmail = "Please Enter Your Email"
    static let enterPassword = "Please Enter Your Password"
    static let enteredWrongPassword = "Entered password is wrong"
    static let shortPassword = "Your password is length is too short"
    static let loadingMessage = "Please wait while your \n data is validating"
    static let errorTitle = "ERROR"
    static let okTitle = "OK"
    static let doneTitle = "Done"
    static let deleteTitle = "Delete"
    
}

struct AlertController{
    static func customSimpleAlertMessage(title: String , message:String , viewController: UIViewController){
        let alert = UIAlertController(title: title , message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }

    
    
    static func showLoadingBar(title: String , message:String , viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let loadingindicator = UIActivityIndicatorView(frame: CGRect(x:5 , y: 8 , width: 50 , height: 50))
        loadingindicator.style = .medium
        loadingindicator.startAnimating()
        alert.view.addSubview(loadingindicator)
        viewController.present(alert, animated: true)
        }
    
    static func hideLoadingBar(viewController: UIViewController){
        let hideLoading = UIActivityIndicatorView()
        hideLoading.stopAnimating()
        viewController.dismiss(animated: true)
    }
}
