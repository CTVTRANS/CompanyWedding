//
//  MessageViewController.swift
//  CompanyWedding
//
//  Created by le kien on 11/17/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import SwiftyJSON

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var contentMsg: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        dateLabel.layer.borderColor = UIColor.rgb(105, 85, 80).cgColor
    }
    
    func binData(message: MessageLog) {
        contentMsg.text = message.content
        dateLabel.text = message.time
    }
    
    func binNotice(notices: FactotyVoucher) {
        contentMsg.text = notices.content
        dateLabel.text = notices.time
    }
}

class MessageViewController: BaseViewController {

    @IBOutlet weak var numberGuest: UILabel!
    @IBOutlet weak var numberMember: UILabel!
    @IBOutlet weak var table: UITableView!
    var listMessage = [MessageLog]()
    var listNotice = [FactotyVoucher]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: self.view)
        setupNavigation()
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 140
        table.tableFooterView = UIView()
        numberMember.text = Company.shared.numberMember.description
        numberGuest.text = Company.shared.numberGuest.description
        getMessage()
    }
    
    func getMessage() {
        let getVoucher = GetVouchers(username: Company.shared.account, key: Company.shared.key)
        requestWith(task: getVoucher) { (data) in
            if let listVoucers = data as? [FactotyVoucher] {
                self.listNotice = listVoucers
                self.table.reloadData()
                self.stopActivityIndicator()
            }
        }
        
        let getMessage = GetMessageTask(username: Company.shared.account, key: Company.shared.key)
        requestWith(task: getMessage) { (data) in
            if let listMessageLog = data as? [MessageLog] {
                self.listMessage = listMessageLog
                self.table.reloadData()
                self.stopActivityIndicator()
            }
        }
    }
}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listNotice.count > 5 ? 5 : listNotice.count
        }
        return listMessage.count > 5 ? 5 : listMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell
        if indexPath.section == 0 {
            cell?.binNotice(notices: listNotice[indexPath.row])
           
        } else {
            cell?.binData(message: listMessage[indexPath.row])
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: widthScreen, height: 40))
        view.backgroundColor = UIColor.rgb(255, 200, 255)
        let titleHeader = UILabel(frame: CGRect(x: 32, y: 0, width: widthScreen, height: 40))
        view.addSubview(titleHeader)
        titleHeader.font = UIFont(name: "HelveticalNeue", size: 15)
        if section == 0 {
            titleHeader.text = "邀約平台貴賓優惠劵"
            titleHeader.adjustFontToRealIPhoneSize = true
        } else {
            titleHeader.text = "賓客App即時訊息"
            titleHeader.adjustFontToRealIPhoneSize = true
        }
        titleHeader.textColor = UIColor.rgb(105, 85, 80)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
