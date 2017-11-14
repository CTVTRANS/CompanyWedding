//
//  LoginController.swift
//  CompanyWedding
//
//  Created by le kien on 11/9/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import SWRevealViewController

class LoginController: BaseViewController, MainStoryboard {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        password.layer.borderColor = UIColor.rgb(233, 130, 139).cgColor
        userName.layer.borderColor = UIColor.rgb(233, 130, 139).cgColor
    }

    @IBAction func pressedLogin(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController {
            self.present(vc, animated: false, completion: nil)
        }
    }
}
