//
//  GetVouchers.swift
//  CompanyWedding
//
//  Created by le kien on 1/15/18.
//  Copyright © 2018 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetVouchers: LKNetwork {
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
        return ["id": username, "k": "ce97e1dce2857e6dff98d61c0e49b23d5cabc2d6"]
    }
    
    override func method() -> HTTPMethod {
        return .GET
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        var listVoucher = [FactotyVoucher]()
        if let jsons = response as? JSON {
            if let arrayNotice = jsons["Vouchers"].array {
                for json in arrayNotice {
                    let notice = FactotyVoucher(json: json)
                    listVoucher.append(notice)
                }
            }
        }
        return listVoucher
    }
}
