//
//  GetNumberNoticeTask.swift
//  CompanyWedding
//
//  Created by le kien on 1/11/18.
//  Copyright © 2018 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetNumberNoticeTask: LKNetwork {
    
    override func path() -> String {
        return getNumberNotice
    }
    override func method() -> HTTPMethod {
        return .GET
    }
    
    override func parameters() -> [String: Any] {
        return ["id": Company.shared.account, "k": Company.shared.key]
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        if let json = response as? JSON {
            Contanst.shared.numberImage = json["count1"].intValue
            Contanst.shared.numberQA = json["count4"].intValue
            Contanst.shared.numberMember = json[""].intValue
            Contanst.shared.numberWebStep = json["count2"].intValue
        }
        return response
    }
}
