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
    let arrayMenu = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "refreshNotification"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
    
    @objc func reload() {
        table.reloadData()
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
            break
        case 3:
            self.openSeat()
        case 4:
            self.openMemberUpload()
        case 5:
            break
        case 6:
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
        let notice = Notice.getNotice()
        name.text = string
        if index < 3 || index > 6 {
            noticeView.isHidden = true
        }
        if index == 3 {
            numberNotice.text = notice.numberSeat.description
            noticeView.isHidden = notice.numberSeat > 0 ? false : true
        } else if index == 4 {
            numberNotice.text = notice.numberTerm.description
            noticeView.isHidden = notice.numberTerm > 0 ? false : true
        } else if index == 5 {
            numberNotice.text = notice.numberMessage.description
            noticeView.isHidden = notice.numberMessage > 0 ? false : true
        } else if index == 6 {
            numberNotice.text = notice.numberMember.description
            noticeView.isHidden = notice.numberMember > 0 ? false : true
        }
    }
}
