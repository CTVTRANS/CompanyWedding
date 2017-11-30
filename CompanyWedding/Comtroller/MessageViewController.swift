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
    @IBOutlet weak var notice: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        dateLabel.layer.borderColor = UIColor.rgb(105, 85, 80).cgColor
    }
    
    func binData(message: Message) {
        contentMsg.text = message.content
        if message.isReaded {
            notice.isHidden = true
        } else {
            notice.isHidden = false
        }
    }
    
    func binNotice(notices: FactotyVoucher) {
        notice.isHidden = true
        contentMsg.text = notices.content
    }
}

class MessageViewController: BaseViewController {

    @IBOutlet weak var table: UITableView!
    var listMessage = [Message]()
    var listNotice = [FactotyVoucher]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 140
        table.tableFooterView = UIView()
        getMessage()
    }
    
    func getMessage() {
        let notice = Notice.getNotice()
        let getMessage = GetMessageTask(username: notice.accountName, password: notice.key)
        requestWith(task: getMessage) { (data) in
            if let json = data as? JSON {
                if let arrayNotice = json["Vouchers"].array {
                    for json in arrayNotice {
                        let message = FactotyVoucher(json: json)
                        self.listNotice.append(message)
                    }
                }
                self.table.reloadData()
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
            let row = listMessage.count > 0 ? listMessage.count : 0
            return row
        }
        let row = listMessage.count > 0 ? listNotice.count : 0
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell
        if indexPath.section == 0 {
            cell?.binData(message: listMessage[indexPath.row])
        } else {
            cell?.binNotice(notices: listNotice[indexPath.row])
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
        if section == 0 {
            titleHeader.text = "1"
        } else {
            titleHeader.text = "2"
        }
        titleHeader.font = UIFont(name: "HelveticalNeue", size: 16)
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
