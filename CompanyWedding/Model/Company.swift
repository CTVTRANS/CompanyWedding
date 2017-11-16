//
//  Company.swift
//  CompanyWedding
//
//  Created by le kien on 11/14/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Company {
    var account = ""
    var name = ""
    var numberGuest = 0
    var numberMember = 0
    
    init(json: JSON) {
        account = json["ACCOUNT"].string!
        name = json["COMPANYNM"].string!
        numberGuest = json["GUEST_NUM"].int!
        numberMember = json["MEMBER_NUM"].int!
    }
    private init() {}
    static var shared = Company()
}
