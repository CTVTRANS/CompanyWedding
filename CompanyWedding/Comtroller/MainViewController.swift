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
    
    @IBOutlet weak var newWebStepView: UIView!
    @IBOutlet weak var newImageView: UIView!
    @IBOutlet weak var newQAView: UIView!
    @IBOutlet weak var memberView: UIView!
    
    @IBOutlet weak var numberImage: UILabel!
    @IBOutlet weak var numberWebStep: UILabel!
    @IBOutlet weak var numberQA: UILabel!
    @IBOutlet weak var numberNewMember: UILabel!
    
    var isNewImage = false {
        didSet {
            newImageView.isHidden = !isNewImage
        }
    }
    var isNewWebStep = false {
        didSet {
            newWebStepView.isHidden = !isNewWebStep
        }
    }
    var isNewQA = false {
        didSet {
            newQAView.isHidden = !isNewQA
        }
    }
    var isNewMember = false {
        didSet {
            memberView.isHidden = !isNewMember
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setupUI), name: NSNotification.Name(rawValue: "refreshNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(requestToServer(notification:)), name: NSNotification.Name(rawValue: "recivePush"), object: nil)
        getCompanyInfo()
        updateToken()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "rightBarButton"), style: .done, target: self, action: nil)
        setupUI()
    }
    
    @objc func setupUI() {
        numberMember.text = Company.shared.numberMember.description
        numberGuest.text = Company.shared.numberGuest.description
        nameCompanyBottom.text = Company.shared.name
        nameCompany.text = Company.shared.name
        setupNotice()
    }
    
    func setupNotice() {
        let numberMemberNew = Contanst.shared.numberMember
        let numberImageNew = Contanst.shared.numberImage
        let numberQANew = Contanst.shared.numberQA
        let numberWebStepNew = Contanst.shared.numberWebStep
        
        isNewMember = numberMemberNew > 0 ? true: false
        numberNewMember.text = numberMemberNew > 9 ? "9": numberMember.description
        isNewQA = numberQANew > 0 ? true: false
        numberQA.text = numberQANew > 9 ? "9": numberQANew.description
        isNewImage = numberImageNew > 0 ? true: false
        numberImage.text = numberImageNew > 9 ? "9": numberImageNew.description
        isNewWebStep = numberWebStepNew > 0 ? true: false
        numberWebStep.text = numberWebStepNew > 9 ? "9": numberWebStepNew.description
    }
    
    @IBAction func pressedOpenWebCompany(_ sender: Any) {
        openCompanyInfo()
    }
    
    @IBAction func pressedSendMessageToMember(_ sender: Any) {
        openMessageView()
    }
    
    @IBAction func pressedOpenWebSeat(_ sender: Any) {
        Contanst.shared.numberWebStep = 0
        let task = UpdateCountNotice(type: 2)
        requestWith(task: task) { (_) in }
        setupNotice()
        openSeat()
    }
    
    @IBAction func pressOpenMemberUploadSeat(_ sender: Any) {
        Contanst.shared.numberImage = 0
        let task = UpdateCountNotice(type: 1)
        requestWith(task: task) { (_) in }
        setupNotice()
        openMemberUpload()
    }
    
    @IBAction func pressedOpenListMember(_ sender: Any) {
        Contanst.shared.numberMember = 0
        let task = UpdateCountNotice(type: 2)
        requestWith(task: task) { (_) in }
        setupNotice()
        openListMember()
    }
    
    @IBAction func pressedMangerCompany(_ sender: Any) {
        self.openManagerCompany()
    }
    
    @IBAction func pressedShare(_ sender: Any) {
        shared()
    }
    
    @IBAction func pressedQAOnline(_ sender: Any) {
        Contanst.shared.numberQA = 0
        let task = UpdateCountNotice(type: 4)
        setupNotice()
        requestWith(task: task) { (_) in }
        openQA()
    }
    
    @objc func requestToServer(notification: Notification) {
        guard let name = notification.object as? String else {
            return
        }
        switch name {
        case "MEMBER_DOC_TOFAC_1":
            Contanst.shared.numberImage += 1
        case "MEMBER_DOC_TOFAC_3":
            Contanst.shared.numberWebStep += 1
        case "MEMBER_REQUEST", "GUEST_REQUEST" :
            Contanst.shared.numberQA += 1
        case "" :
            Contanst.shared.numberMember += 1
        default:
            getNotice()
        }
        self.setupNotice()
    }
    
    func updateToken() {
        if Contanst.shared.token == "" {
            return
        }
        let task = UpdateToken(token: Contanst.shared.token)
        requestWith(task: task) { (_) in
        }
    }
}

extension MainViewController {
    func getCompanyInfo() {
        showActivity(inView: self.view)
        let cacheCompany = Cache<Company>()
        let company: Company = cacheCompany.fetchObject()!
        let login = LoginTask(username: company.account, key: company.key)
        requestWith(task: login, success: { (_) in
            self.setupUI()
            self.setupNotice()
            self.stopActivityIndicator()
        })
    }
    
    func getNotice() {
        let task = GetNumberNoticeTask()
        requestWith(task: task) { (_) in
            self.setupNotice()
        }
    }
}
