//
//  MainViewController.swift
//  CompanyWedding
//
//  Created by le kien on 11/9/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, MainStoryboard {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "rightBarButton"), style: .done, target: self, action: nil)
    }
    @IBAction func pressedOpenWebCompany(_ sender: Any) {
        self.openCompanyInfo()
    }
    @IBAction func pressedSendMessageToMember(_ sender: Any) {
        
    }
    @IBAction func pressedOpenWebSeat(_ sender: Any) {
        self.openSeat()
    }
    
    @IBAction func pressOpenMemberUploadSeat(_ sender: Any) {
        self.openMemberUpload()
    }
    
    @IBAction func pressedOpenListMember(_ sender: Any) {
        self.openListMember()
    }
    
    @IBAction func pressedMangerCompany(_ sender: Any) {
        self.openManagerCompany()
    }
}
