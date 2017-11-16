//
//  LoginTask.swift
//  CompanyWedding
//
//  Created by le kien on 11/14/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginTask: LKNetwork {
    
    var username: String!
    let key: String!
    
    init(username: String, password: String) {
        self.username = username
        let crytor = "id=" + username + "password=" + password + "key=123"
        self.key = crytor.sha1()
    }
    
    override func path() -> String {
        return loginURL
    }
    
    override func parameters() -> [String: Any] {
        return ["id": username, "k": "ce97e1dce2857e6dff98d61c0e49b23d5cabc2d6"]
    }
    
    override func method() -> HTTPMethod {
        return .GET
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        if let json = response as? JSON {
            Company.shared = Company.init(json: json)
            let notice = Notice.getNotice()
            notice.key = key
            Notice.saveNotice(noice: notice)
        }
        return response
    }
}
