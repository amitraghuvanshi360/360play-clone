//
//  TicketData.swift
//  360play clone
//
//  Created by Ankush Sharma on 04/04/23.
//

import Foundation


struct Ticket{
    var username:String
    var email:String
    var contact:String
    var duration:Int
    var servicetype:String
    var numberOfTickets:Int
    
    init(username: String, email: String, contact: String, duration: Int, servicetype: String, numberOfTickets: Int) {
        self.username = username
        self.email = email
        self.contact = contact
        self.duration = duration
        self.servicetype = servicetype
        self.numberOfTickets = numberOfTickets
    }
}
enum Title: String{
    case Name = "Name"
    case Email = "Email"
    case Contact = "Contact"
    case ServiceType = "Service Type"
    case Duration = "Duration"
    case Tickets = "Tickets"
    
    static let titleData = [Name , Email , Contact, ServiceType , Duration, Tickets]
}
