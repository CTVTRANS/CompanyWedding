//
//  Company.swift
//  CompanyWedding
//
//  Created by le kien on 11/14/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Company {
    
    static let kAccount = "account"
    static let kName = "name"
    static let kKey = "key"
    static let kNumberGuest = "numberGuest"
    static let kNumberMember = "numberMember"
    
    var account = ""
    var name = ""
    var key = ""
    var numberGuest = 0
    var numberMember = 0
    
    static func decodeJson(json: JSON) -> Company {
        return Company(account: json["ACCOUNT"].stringValue,
                       name: json["COMPANYNM"].stringValue,
                       key: json[""].stringValue,
                       numberGuest: json["GUEST_NUM"].intValue,
                       numberMember: json["MEMBER_NUM"].intValue)
    }
    static var shared = Company()
}

extension HeperCompany: Encodable {
    var value: Company? {
        return company
    }
}

extension Company: Encoded {
    var encoder: HeperCompany {
        return HeperCompany(company: self)
    }
}

class HeperCompany: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(company?.account, forKey: Company.kAccount)
        aCoder.encode(company?.name, forKey: Company.kName)
        aCoder.encode(company?.key, forKey: Company.kKey)
        aCoder.encode(company?.numberGuest, forKey: Company.kNumberGuest)
        aCoder.encode(company?.numberMember, forKey: Company.kNumberMember)
    }
    
    var company: Company?
    
    init(company: Company) {
        self.company = company
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let account = aDecoder.decodeObject(forKey: Company.kAccount) as? String,
            let name = aDecoder.decodeObject(forKey: Company.kName) as? String,
            let key = aDecoder.decodeObject(forKey: Company.kKey) as? String,
            let numberGuest = aDecoder.decodeObject(forKey: Company.kNumberGuest) as? Int,
            let numberMemberr = aDecoder.decodeObject(forKey: Company.kNumberMember) as? Int else {
                company = nil
                super.init()
                return nil
        }
        
        company = Company(account: account,
                          name: name,
                          key: key,
                          numberGuest: numberGuest,
                          numberMember: numberMemberr)
        super.init()
    }
}
