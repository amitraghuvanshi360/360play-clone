//
//  ViewController.swift
//  360play clone
//
//  Created by Ankush Sharma on 27/03/23.
//

import UIKit


class Ankush {
    var counter: Int = 8
}


class ViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var continueBttn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        continueBttn.layer.cornerRadius = 20
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    
    @IBAction func proceedBttnAction(_ sender: Any) {
        let userEmail = self.emailTextField.text!
        let userPassword = self.passwordTextField.text!
        self.loadinHubShow()
        if !Validate.isValidEmailAddress(emailAddressString: userEmail){
            AlertController.ALERT_MESSAGE(title: Constant.ERROR, message: Constant.EnterEmail, viewController: self)
            return
            
        }else if(userPassword == ""){
            AlertController.ALERT_MESSAGE(title: Constant.ERROR, message: Constant.EnterPassword, viewController: self)
            return
        }else if(userPassword.count < 6){
            AlertController.ALERT_MESSAGE(title: Constant.ERROR, message: Constant.SHORT_PASSWORD, viewController: self)
            return
        }
        
        APIManager.userAuthenticationRequest(email: userEmail, password: userPassword) { modelData, errorMsg in
            if let errorStr = errorMsg {
                DispatchQueue.main.async {
                    AlertController.ALERT_MESSAGE(title: Constant.ERROR, message: errorStr, viewController: self)
                    return
                }
            }
            
            if let dataOBj = modelData {
                DispatchQueue.main.async {
                    self.setData(email: dataOBj.email, id: dataOBj.id)
                    APIManager.getGameSlotRequest(gameId: 22)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabBarVC") as! CustomTabBarVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}


extension ViewController{
    private func setData(email:String , id:Int){
        UserDefaults.standard.set(email, forKey: "userEmail")
        UserDefaults.standard.set(id, forKey: "userID")
        
    }
    func loadinHubShow() {
//                    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
//                    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
//                    loadingIndicator.hidesWhenStopped = true
//                    loadingIndicator.style = UIActivityIndicatorView.Style.gray
//                    loadingIndicator.startAnimating();
//                    alert.view.addSubview(loadingIndicator)
//                    present(alert, animated: true, completion: nil)
        let alert = UIAlertController(title: nil, message: "Please wait while we validating your data", preferredStyle: .alert)
        let loadingindicator = UIActivityIndicatorView(frame: CGRect(x: 30, y: 40 , width: 100 , height: 100))
        }
}

