//
//  MainViewController.swift
//  CompanyWedding
//
//  Created by le kien on 11/9/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, MainStoryboard {

    @IBOutlet weak var nameCompany: UILabel!
    @IBOutlet weak var nameCompanyBottom: UILabel!
    @IBOutlet weak var numberGuest: UILabel!
    @IBOutlet weak var numberMember: UILabel!
    
    @IBOutlet weak var newTermOfUseView: UIView!
    @IBOutlet weak var newSeatView: UIView!
    @IBOutlet weak var newMessageView: UIView!
    @IBOutlet weak var memberView: UIView!
    
    @IBOutlet weak var numberSeat: UILabel!
    @IBOutlet weak var numberTermOfUse: UILabel!
    @IBOutlet weak var numberMessage: UILabel!
    @IBOutlet weak var numberNewMember: UILabel!
    
    var isNewSeat = false {
        didSet {
            newSeatView.isHidden = !isNewSeat
        }
    }
    var isNewTerm = false {
        didSet {
            newTermOfUseView.isHidden = !isNewTerm
        }
    }
    var isNewMessage = false {
        didSet {
            newMessageView.isHidden = !isNewMessage
        }
    }
    var isNewMember = false {
        didSet {
            memberView.isHidden = !isNewMember
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "rightBarButton"), style: .done, target: self, action: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setupNotice), name: NSNotification.Name(rawValue: "refreshNotification"), object: nil)
    }
    
    func setupUI() {
        numberMember.text = Company.shared.numberMember.description
        numberGuest.text = Company.shared.numberGuest.description
        nameCompanyBottom.text = Company.shared.name
        nameCompany.text = Company.shared.name
    }
    
    @objc func setupNotice() {
        let notice = Notice.getNotice()
        isNewMember = notice.numberMember > 0 ? true : false
        numberNewMember.text = notice.numberMember.description
        isNewSeat = notice.numberSeat > 0 ? true : false
        numberSeat.text = notice.numberSeat.description
        isNewTerm = notice.numberTerm > 0 ? true : false
        numberTermOfUse.text = notice.numberTerm.description
        isNewMessage = notice.numberMessage > 0 ? true : false
        numberMessage.text = notice.numberMessage.description
    }
    
    @IBAction func pressedOpenWebCompany(_ sender: Any) {
        self.openCompanyInfo()
    }
    
    @IBAction func pressedSendMessageToMember(_ sender: Any) {
        openMessageView()
    }
    
    @IBAction func pressedOpenWebSeat(_ sender: Any) {
        let notice = Notice.getNotice()
        notice.numberSeat = 0
        Notice.saveNotice(noice: notice)
        self.openSeat()
    }
    
    @IBAction func pressOpenMemberUploadSeat(_ sender: Any) {
        let notice = Notice.getNotice()
        notice.numberTerm = 0
        Notice.saveNotice(noice: notice)
        self.openMemberUpload()
    }
    
    @IBAction func pressedOpenListMember(_ sender: Any) {
        let notice = Notice.getNotice()
        notice.numberMember = 0
        Notice.saveNotice(noice: notice)
        self.openListMember()
    }
    
    @IBAction func pressedMangerCompany(_ sender: Any) {
        self.openManagerCompany()
    }
    
    @IBAction func pressedShare(_ sender: Any) {
        shared()
    }
    
    @IBAction func pressedQAOnline(_ sender: Any) {
        openQA()
        let notice = Notice.getNotice()
        notice.numberSeat = 0
        Notice.saveNotice(noice: notice)
    }
}
