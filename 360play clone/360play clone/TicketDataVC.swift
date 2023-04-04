//
//  TicketDataViewController.swift
//  360play clone
//
//  Created by Ankush Sharma on 03/04/23.
//

import Foundation
import UIKit


class TicketDataVC: UIViewController {
    
    var ticketDetails:[Ticket]?
    var titleData: [Title]?
    @IBOutlet private weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TicketDataVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ticketDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableCell", for: indexPath) as! CustomTableCell
        if let data = ticketDetails{
            cell.setData(title: "title", data: ticketDetails?[indexPath.row].email ?? "as@gmail.com")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80    }
}

class CustomTableCell: UITableViewCell{
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setData(title:String , data:String){
        titleLabel.text = title
        dataLabel.text = data
    }
}


