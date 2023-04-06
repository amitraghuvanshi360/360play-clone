//
//  TicketDataViewController.swift
//  360play clone
//
//  Created by Ankush Sharma on 03/04/23.
//

import Foundation
import UIKit


class TicketDataVC: UIViewController {
    
    var ticketDetailsArr: [Ticket] = []
    var titleString:String = ""

    @IBOutlet private weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
}
extension TicketDataVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ticketDetailsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if self.ticketDetailsArr[indexPath.row].dataType == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableCell", for: indexPath) as! CustomTableCell

            cell.setData(dataObj: self.ticketDetailsArr[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomViewCell", for: indexPath) as! CustomViewCell
            print(self.ticketDetailsArr[indexPath.row].value)
            cell.setPrice(total: titleString)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


class CustomTableCell: UITableViewCell{
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewLayout: UIView!
    
    func setData(dataObj: Ticket){
        print(dataObj)
        titleLabel.text = dataObj.title
        dataLabel.text = dataObj.value
        customCellStyle()
    }
    
    func customCellStyle(){
        viewLayout.layer.borderColor = UIColor.gray.cgColor
        viewLayout.layer.borderWidth = 1
        dataLabel.textColor = UIColor(red: 19/255.0, green: 89/255.0, blue: 26/255.0, alpha: 1)
        dataLabel.font = .boldSystemFont(ofSize: 17)
    }
}


class CustomViewCell: UITableViewCell{
    @IBOutlet weak var totalTicketView: UIView!
    
    @IBOutlet weak var totalAmountLbl: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setPrice(total: String){
        totalAmountLbl.text = "Total Price : \(total)"
    }
    
}

