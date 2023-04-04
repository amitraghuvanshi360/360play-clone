//
//  TicketBookingVC.swift
//  360play clone
//
//  Created by Ankush Sharma on 27/03/23.
//

import Foundation
import UIKit
import iOSDropDown



class TicketBookingVc: UIViewController, UIScrollViewDelegate {
        
    //color code 5AAD30
    private var payment: Payment?
    private var paymentData: [Datum]? = []

    private var group:Group?
    private var ageType:[ageGroup]? = []
    
    private var game:Game?
    private var gameData: [gameType]? = []

    private var ticketDetails:[Ticket]?
    private var isGenderSelected:Bool = false
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var nameTxtField: UITextField!
    @IBOutlet private weak var emailTxtField: UITextField!
    @IBOutlet private weak var contactTxtField: UITextField!
    @IBOutlet private weak var additionalPhoneTxtField: UITextField!
    @IBOutlet private weak var qidTxtField: UITextField!
    @IBOutlet private weak var maleSelectBttn: UIButton!
    @IBOutlet private weak var femaleSelectBttn: UIButton!
    @IBOutlet private weak var otherSelectionBttn: UIButton!
    
    @IBOutlet private weak var paymentTextField: DropDown!
    @IBOutlet private weak var ageTextField: DropDown!
    @IBOutlet private weak var gameTextField: DropDown!
    @IBOutlet private weak var nationalityTextField: DropDown!

    @IBOutlet private weak var ticketCounterBtnn: UIButton!
    @IBOutlet private weak var totalTicketsLbl: UILabel!
    @IBOutlet private weak var addTicketBttn: UIButton!
    @IBOutlet private weak var decrementTicketBttn: UIButton!
    @IBOutlet private weak var continueBttn: UIButton!
    private var ticketCounter:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView?.delegate = self
        self.setCustomStyle()
        navigationController?.isNavigationBarHidden = false  // to hide navigation bar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getPaymentAPI()
        self.getAgeAPI()
        self.setNationalityType()
        self.getGameAPI()
    }
    
    
//    MARK: Button layouts
    private func setCustomStyle(){
        ticketCounterBtnn.layer.borderWidth = 2
        continueBttn.layer.borderWidth = 2
        
        addTicketBttn.layer.borderWidth = 2
        decrementTicketBttn.layer.borderWidth = 2

        continueBttn.layer.cornerRadius = 25
        
        ticketCounterBtnn.layer.borderColor = UIColor.lightText.cgColor
        continueBttn.layer.borderColor = UIColor.lightText.cgColor

        addTicketBttn.layer.borderColor = UIColor.lightText.cgColor
        decrementTicketBttn.layer.borderColor = UIColor.lightText.cgColor
    }
    
//    MARK: Api call for paymentType
    private func getPaymentAPI(){
        DispatchQueue.global().async {
            // Api request for payment
            APIManager.paymentTypeAPIRequest { data in
                self.payment = data as? Payment
                self.paymentData = self.payment?.data
                DispatchQueue.main.async {
                    self.setPaymentType(data: self.paymentData) // set payment data
                }
            }
        }
    }
//    MARK: set age type
    private func getAgeAPI(){
        DispatchQueue.global().async {
            // Api request for payment
            APIManager.ageGroupAPIRequest{ data in
                self.group = data as? Group
                self.ageType = self.group?.data
                DispatchQueue.main.async {
                    self.setAgeType(age: self.ageType)        // set age data
                }
            }
        }
    }
// MARK: set game type
    private func getGameAPI(){
        DispatchQueue.global().async {
            // Api request for payment
            APIManager.gameListAPIRequest{data in
                self.game = data as? Game
                self.gameData = self.game?.data
                DispatchQueue.main.async {
                    self.setGameType(game: self.gameData)        // set age data
                }
            }
        }
    }
    
//    MARK: set payment types in list

    private func setPaymentType(data: [Datum]?){
        self.paymentTextField.optionArray = []
        guard let paymentDataArray = data else {
            return
        }
        
        for (index, paymentType) in paymentDataArray.enumerated() {
            self.paymentTextField.optionArray.append(paymentType.name)
        }
        
        self.paymentTextField.layer.borderWidth = 0
        self.paymentTextField.didSelect{ [self](selectedText , index ,id) in
        }
    }
    
// MARK: Set ageData in list
    private func setAgeType(age: [ageGroup]?){
        self.ageTextField.optionArray = []
        guard let ageDataArray = age else {
            return
        }
        
        for (index, ageTypes) in ageDataArray.enumerated() {
            self.ageTextField.optionArray.append(ageTypes.name)
        }
        self.ageTextField.layer.borderWidth = 0
        self.ageTextField.didSelect{ [self](selectedText , index ,id) in
        }
    }
    
//MARK: Set nationality in list
    private func setNationalityType(){
        nationalityTextField.optionArray = ["India" ,"Oman" ,"Quatar", "Philippines", "Egypt","Sri Lanka", "Omani" , "Bahraini", "Afghan" , "Albanian", "Algerian", "Argentine", "Argentinian", "Australian", "Austrian", "Bangladeshi", "Belgian", "Bolivian", "Batswana" ,"Brazilian" ,"Bulgarian", "Cambodian", "Cameroonian", "Canadian"]
    }
//MARK: Set gameData in list
    private func setGameType(game: [gameType]?){
        self.gameTextField.optionArray = []
        guard let gameDataArray = game else{
            return
        }
    
        for (index, gamelist) in gameDataArray.enumerated() {
            self.gameTextField.optionArray.append(gamelist.name)
        }
        self.gameTextField.layer.borderWidth = 0
        self.gameTextField.didSelect{ [self](selectedText , index ,id) in
        }
    }
    
    
    @IBAction func maleSelectionAction(_ sender: UIButton) {
        self.setRadioButtons(sender: sender)
        
    }
    
    @IBAction func femaleSelectionAction(_ sender: UIButton) {
        self.setRadioButtons(sender: sender)
    }
    
    @IBAction func otherSelectionAction(_ sender: UIButton) {
        self.setRadioButtons(sender: sender)
    }
    
    @IBAction func incrementTicketCounter(_ sender: Any) {
        self.ticketCounter += 1
        self.checkCounterRange(counter: self.ticketCounter)
    }
    @IBAction func decrementTicketCounter(_ sender: Any) {
        self.ticketCounter -= 1
        self.checkCounterRange(counter: self.ticketCounter)
    }
    
    @IBAction func proceedToNextAction(_ sender: Any) {
        print("Button Pressed")
        
        let userName = self.nameTxtField.text!
        let userEmail = self.emailTxtField.text!
        let userContact = self.contactTxtField.text!
        let totalTickets = self.ticketCounter
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TicketDataVC") as! TicketDataVC
//        let data = self.ticketDetails?.append(contentsOf: userName)
        
        vc.ticketDetails = [Ticket(username: userName, email: userEmail, contact: userContact, duration: 4, servicetype: "family func", numberOfTickets: ticketCounter)]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func checkCounterRange(counter: Int){
        if counter > 10 || counter <= 0 {
            self.ticketCounter = 0
            self.totalTicketsLbl.text = "\(ticketCounter) TICKETS"
            return
        }else{
            self.totalTicketsLbl.text = "\(self.ticketCounter) TICKETS"
        }
    }
    private func setRadioButtons(sender: UIButton) {
        print(sender)
        maleSelectBttn.isSelected = false
        femaleSelectBttn.isSelected = false
        otherSelectionBttn.isSelected = false
        maleSelectBttn.setImage(UIImage(named: "unselected"), for: .normal)
        femaleSelectBttn.setImage(UIImage(named: "unselected"), for: .normal)
        otherSelectionBttn.setImage(UIImage(named: "unselected"), for: .normal)
        if sender.isSelected == false {
            sender.setImage(UIImage(named: "genderselected"), for: .normal)
            sender.isSelected = false
        }else{
            sender.setImage(UIImage(named: "unselected"), for: .normal)
            sender.isSelected = true
        }
    }
}

