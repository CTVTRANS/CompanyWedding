//
//  LeftMenuViewController.swift
//  CompanyWedding
//
//  Created by le kien on 11/9/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class LeftMenuViewController: BaseViewController {

    @IBOutlet weak var table: UITableView!
    let arrayMenu = ["檢視廠商平台", "分享廠商平台", "活動訊息發佈", "線上新人列表", "桌位圖表上傳", "婚宴流程表上傳", "線上諮詢回覆", "廠商平台管理"]
    let notificationName = Notification.Name("refreshNotification")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "recivePush"), object: nil)
        table.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
    
    @objc func reload() {
        table.reloadData()
    }
    
    @IBAction func pressedBackHome(_ sender: Any) {
        let navigationVC = swVC?.frontViewController as? UINavigationController
        navigationVC?.popToRootViewController(animated: false)
        swVC?.pushFrontViewController(navigationVC, animated: true)
    }
}

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MenuCell
        cell?.binData(arrayMenu[indexPath.row], at: indexPath.row)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        swVC?.revealToggle(animated: true)
        switch row {
        case 0:
            self.openCompanyInfo()
        case 1:
            shared()
        case 2:
            openMessageView()
        case 3:
            Contanst.shared.numberImage = 0
            let task = UpdateCountNotice(type: 0)
            requestWith(task: task) { (_) in }
            NotificationCenter.default.post(name: notificationName, object: nil)
            self.openSeat()
        case 4:
            Contanst.shared.numberWebStep = 0
            let task = UpdateCountNotice(type: 1)
            requestWith(task: task) { (_) in }
            NotificationCenter.default.post(name: notificationName, object: nil)
            self.openMemberUpload()
        case 5:
            Contanst.shared.numberQA = 0
            let task = UpdateCountNotice(type: 2)
            requestWith(task: task) { (_) in }
            NotificationCenter.default.post(name: notificationName, object: nil)
            openQA()
        case 6:
            Contanst.shared.numberMember = 0
            let task = UpdateCountNotice(type: 3)
            requestWith(task: task) { (_) in }
            NotificationCenter.default.post(name: notificationName, object: nil)
            self.openListMember()
        case 7:
            self.openManagerCompany()
        default:
            break
        }
    }
}

class MenuCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var numberNotice: UILabel!
    @IBOutlet weak var noticeView: UIView!
    
    override func awakeFromNib() {
        
    }

    func binData(_ string: String, at index: Int) {
        name.text = string
        if index < 3 || index > 6 {
            noticeView.isHidden = true
        }
        if index == 3 {
            numberNotice.text = Contanst.shared.numberImage.description
            noticeView.isHidden = Contanst.shared.numberImage > 0 ? false : true
        } else if index == 4 {
            numberNotice.text = Contanst.shared.numberWebStep.description
            noticeView.isHidden = Contanst.shared.numberWebStep > 0 ? false : true
        } else if index == 5 {
            numberNotice.text = Contanst.shared.numberQA.description
            noticeView.isHidden = Contanst.shared.numberQA > 0 ? false : true
        } else if index == 6 {
            numberNotice.text = Contanst.shared.numberMember.description
            noticeView.isHidden = Contanst.shared.numberMember > 0 ? false : true
        }
    }
}
