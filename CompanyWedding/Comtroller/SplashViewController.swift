//
//  SplashViewController.swift
//  CompanyWedding
//
//  Created by le kien on 11/30/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import SWRevealViewController

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let notice = Notice.getNotice()
        if notice.accountName != "" {
            let login = LoginTask(username: notice.accountName, password: notice.key)
            requestWith(task: login, success: { (_) in
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController {
                    self.present(vc, animated: false, completion: nil)
                }
            })
        } else {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as? UINavigationController {
//                navigationController?.pushViewController(vc, animated: false)
                self.present(vc, animated: false, completion: nil)
            }
        }
    }

}
