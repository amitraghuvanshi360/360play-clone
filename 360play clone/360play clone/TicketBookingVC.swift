//
//  TicketBookingVC.swift
//  360play clone
//
//  Created by Ankush Sharma on 27/03/23.
//

import Foundation
import UIKit
import iOSDropDown

enum Title: String{
    case Name = "Name"
    case Email = "Email"
    case Contact = "Contact"
    case Duration = "Duration"
    case ServiceType = "Service Type"
    case Tickets = "Tickets"
    case CustomView = "CustomView"
}

class TicketBookingVc: UIViewController, UIScrollViewDelegate {
        
    //color code 5AAD30
    private var payment: Payment?
    private var paymentData: [Datum]? = []

    private var group:Group?
    private var ageType:[ageGroup]? = []
    
    private var game:Game?
    private var gameData: [gameType]? = []
    private var gameIdData = [Int]()

    private var ticketDetails:[Ticket]?
    private var titleData:String = ""
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
    
    @IBOutlet weak var subscriptionStackVw: UIStackView!
    @IBOutlet weak var subscriptionView: UIView!
    @IBOutlet weak var halfSubscription: UIButton!
    @IBOutlet weak var hourSubscription: UIButton!
    @IBOutlet weak var daySubscription: UIButton!
    @IBOutlet weak var familySubscription: UIButton!
    
    @IBOutlet weak var halfSubscriptionLbl: UILabel!
    @IBOutlet weak var hourSubscriptionLbl: UILabel!
    @IBOutlet weak var daySubscriptionLbl: UILabel!
    @IBOutlet weak var familySubscriptionLbl: UILabel!
    
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
        let userId = UserDefaults.standard.object(forKey: "userID")
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
        self.ticketCounterBtnn.layer.borderWidth = 2
        self.continueBttn.layer.borderWidth = 2
        
        self.addTicketBttn.layer.borderWidth = 2
        self.decrementTicketBttn.layer.borderWidth = 2
        
      

        self.continueBttn.layer.cornerRadius = 25
        
        self.ticketCounterBtnn.layer.borderColor = UIColor.lightText.cgColor
        self.continueBttn.layer.borderColor = UIColor.lightText.cgColor

        self.addTicketBttn.layer.borderColor = UIColor.lightText.cgColor
        self.decrementTicketBttn.layer.borderColor = UIColor.lightText.cgColor
        
        self.halfSubscription.layer.borderColor  = UIColor.lightGray.cgColor
        self.familySubscription.layer.borderColor = UIColor.lightGray.cgColor
        self.daySubscription.layer.borderColor = UIColor.lightGray.cgColor
        self.hourSubscription.layer.borderColor = UIColor.lightGray.cgColor
        
        self.halfSubscription.layer.borderWidth = 1
        self.familySubscription.layer.borderWidth = 1
        self.daySubscription.layer.borderWidth = 1
        self.hourSubscription.layer.borderWidth = 1

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
            self.gameIdData.append(gamelist.id)
        }
        self.gameTextField.layer.borderWidth = 0
        self.gameTextField.didSelect{ [self](selectedText , index ,id) in
            let gameid = self.gameIdData[index]
            self.getGameSlotIndex(id: gameid , index: index)
        }
    }
    
    private func getGameSlotIndex(id: Int , index: Int){
        APIManager.getGameSlotRequest(gameId: id, completion: { data in
            DispatchQueue.main.async {
                self.setGameSlot(data: data , index: index)
            }
        })
    }
    
    
    private func setGameSlot(data: GameSlot? , index: Int){
        self.halfSubscriptionLbl.text = data?.data[0].description
        self.hourSubscriptionLbl.text = data?.data[1].description
        self.daySubscriptionLbl.text = data?.data[2].description
        self.familySubscriptionLbl.text = data?.data[3].description
        
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
    
    @IBAction func halfSubscriptionAction(_ sender: UIButton) {
        self.selectSubscriptionChoice(sender: sender)
    }
    
    @IBAction func hourSubscriptionAction(_ sender: UIButton) {
        self.selectSubscriptionChoice(sender: sender)
    }
    @IBAction func daySubscriptionAction(_ sender: UIButton) {
        self.selectSubscriptionChoice(sender: sender)
    }
    
    @IBAction func familySubscriptionAction(_ sender: UIButton) {
        self.selectSubscriptionChoice(sender: sender)
    }
    
    @IBAction func proceedToNextAction(_ sender: UIButton) {
        let userName = self.nameTxtField.text!
        let userEmail = self.emailTxtField.text!
        let userContact = self.contactTxtField.text!
        let duration = 60
        let totalTickets = self.ticketCounter
        let senderTitle = self.titleData
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TicketDataVC") as! TicketDataVC
        
        let dataObj : [Ticket] = [Ticket.init(title: Title.Name.rawValue, value: userName),
                                  Ticket.init(title: Title.Email.rawValue, value: userEmail),
                                  Ticket.init(title: Title.Contact.rawValue, value: userContact),
                                  Ticket.init(title: Title.Duration.rawValue, value: String(duration)),
                                  Ticket.init(title: Title.ServiceType.rawValue, value: senderTitle),
                                  Ticket.init(title: Title.Tickets.rawValue, value: String(ticketCounter)),
                                  Ticket.init(title: Title.CustomView.rawValue, value: "", dataType: 1)
                                  
        ]
    
        
        vc.ticketDetailsArr = dataObj
        vc.titleString = String( self.ticketCounter * duration)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func checkCounterRange(counter: Int){
        if counter > 10 || counter <= 0 {
            self.ticketCounter = 0
            self.totalTicketsLbl.text = "\(ticketCounter) TICKETS"
            return
        }else{
            self.totalTicketsLbl.text = "\(self.ticketCounter) TICKETS"
        }
    }
    
    private func selectSubscriptionChoice(sender: UIButton){
        self.halfSubscription.backgroundColor = .none
        self.hourSubscription.backgroundColor = .none
        self.daySubscription.backgroundColor = .none
        self.familySubscription.backgroundColor = .none
        if sender.isSelected {
            sender.backgroundColor = .white
            sender.isSelected = false
            self.titleData = sender.currentTitle ?? ""
        }else{
            sender.backgroundColor = .green
            print(sender.isSelected)
            self.titleData = sender.currentTitle ?? ""
            sender.isSelected = true
        }
    }
    private func setRadioButtons(sender: UIButton) {
        self.maleSelectBttn.setImage(UIImage(named: "unselected"), for: .normal)
        self.femaleSelectBttn.setImage(UIImage(named: "unselected"), for: .normal)
        self.otherSelectionBttn.setImage(UIImage(named: "unselected"), for: .normal)
        if sender.isSelected == false {
            sender.setImage(UIImage(named: "genderselected"), for: .normal)
            sender.isSelected = false
        }else{
            sender.setImage(UIImage(named: "unselected"), for: .normal)
            sender.isSelected = true
        }
    }
}
