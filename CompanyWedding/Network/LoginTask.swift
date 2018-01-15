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
    
    init(username: String, key: String) {
        self.username = username
        self.key = key
    }
    
    override func path() -> String {
        return loginURL
    }
    
    override func parameters() -> [String: Any] {
        return ["id": username, "k": key]
    }
    
    override func method() -> HTTPMethod {
        return .GET
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        if let json = response as? JSON {
            Company.shared = Company.decodeJson(json: json)
            return response
        }
        return response
    }
}
