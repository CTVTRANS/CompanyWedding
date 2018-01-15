//
//  UpdateCountNotice.swift
//  CompanyWedding
//
//  Created by le kien on 1/11/18.
//  Copyright © 2018 le kien. All rights reserved.
//

import Foundation

class UpdateCountNotice: LKNetwork {
    
    var type = 0
    
    init(type: Int) {
        self.type = type
    }
    
    override func path() -> String {
        return updateCountNotice
    }
    
    override func method() -> HTTPMethod {
        return .GET
    }
    
    override func parameters() -> [String : Any] {
        return ["id": Company.shared.account, "t": type]
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        return response
    }
}
