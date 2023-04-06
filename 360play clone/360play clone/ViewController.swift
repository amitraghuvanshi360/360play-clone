//
//  ViewController.swift
//  360play clone
//
//  Created by Ankush Sharma on 27/03/23.
//

import UIKit



class ViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var continueBttn: UIButton!
    
    
    //MARK: - View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLayoutUpdate()
    }
    
    
    //MARK: - Buttons Actions
    @IBAction private func proceedBttnAction(_ sender: Any) {
        let userEmail = self.emailTextField.text ?? ""
        let userPassword = self.passwordTextField.text ?? ""
        
        let errorMsg = self.errorMessageForAlertFunc(userEmail: userEmail, userPassword: userPassword)
        if !errorMsg.isEmpty {
            AlertController.customSimpleAlertMessage(title: Constant.errorTitle, message: errorMsg, viewController: self)
            return
        }
        
        AlertController.showLoadingBar(title: "", message: Constant.loadingMessage, viewController: self)
        APIManager.userAuthenticationRequest(email: userEmail, password: userPassword) { [weak self] modelData, errorMsg in
            
            DispatchQueue.main.async {
                guard let unwappedSelf = self else {
                    return
                }
                
                AlertController.hideLoadingBar(viewController: unwappedSelf)
                if let errorStr = errorMsg {
                    AlertController.customSimpleAlertMessage(title: Constant.errorTitle, message: errorStr, viewController: unwappedSelf)
                    return
                }
                if let dataOBj = modelData {
                    unwappedSelf.navigateToNextVC(user: dataOBj)
                }
                
            }//Dispatch main block
            
        }//ALertView Controller
    }
}


extension ViewController {
    
    private func initialLayoutUpdate() {
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.continueBttn.layer.cornerRadius = 20
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setUserDefaultsData(email:String , id:Int){
        UserDefaults.standard.set(email, forKey: "userEmail")
        UserDefaults.standard.set(id, forKey: "userID")

    }
    
    private func navigateToNextVC(user: User) {
        self.setUserDefaultsData(email: user.email, id: user.id)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabBarVC") as! CustomTabBarVC
        vc.userObj = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func errorMessageForAlertFunc(userEmail: String, userPassword: String) -> String {
        var errorMsg = ""
        if userEmail.isEmpty {
            errorMsg = Constant.enterEmail
        } else if userPassword.isEmpty {
            errorMsg = Constant.enterPassword
        } else if !Validate.isValidEmailAddress(emailAddressString: userEmail) {
            errorMsg = Constant.enterValidEmail
        }else if(userPassword.count < 6){
            errorMsg = Constant.enterValidEmail
        }
        return errorMsg
       
    }
}

