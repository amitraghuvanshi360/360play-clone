//
//  TicketData.swift
//  360play clone
//
//  Created by Ankush Sharma on 04/04/23.
//

import Foundation
import UIKit

// dataType = 0 -> normal cell
// dataType = 1 -> CustomView
class Ticket{
    
    var dataType: Int
    var title: String
    var value: String
    
    init(title: String, value: String, dataType: Int = 0) {
        self.title = title
        self.value = value
        self.dataType = dataType
    }

}

