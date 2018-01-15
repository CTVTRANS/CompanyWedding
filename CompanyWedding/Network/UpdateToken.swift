//
//  UpdateToken.swift
//  CompanyWedding
//
//  Created by le kien on 1/2/18.
//  Copyright © 2018 le kien. All rights reserved.
//

import Foundation

class UpdateToken: LKNetwork {
    
    var token = ""
    
    init(token: String) {
        self.token = token
    }
    
    override func path() -> String {
        let cacheCompany = Cache<Company>()
        let company = cacheCompany.fetchObject()
        if company != nil {
            return loginURL + "id=\(company!.account)&k=\(company!.key)"
        }
        return ""
    }
    
    override func parameters() -> [String: Any] {
        return ["token": token]
    }
    
    override func method() -> HTTPMethod {
        return .POST
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        return response
    }
}
