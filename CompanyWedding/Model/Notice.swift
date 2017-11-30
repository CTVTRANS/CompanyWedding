//
//  Notice.swift
//  CompanyWedding
//
//  Created by le kien on 11/14/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class Notice: NSObject, NSCoding {
    
    var accountName: String!
    var numberMessage: Int!
    var numberSeat: Int!
    var numberTerm: Int!
    var numberMember: Int!
    var key: String!
    
    init(numberMessage: Int, numberSeat: Int, numberTerm: Int, numberMember: Int, key: String, account: String) {
        self.numberMessage = numberMessage
        self.numberSeat = numberSeat
        self.numberTerm = numberTerm
        self.numberMember = numberMember
        self.key = key
        self.accountName = account
    }
    
    required init?(coder aDecoder: NSCoder) {
        numberMessage = aDecoder.decodeObject(forKey: "numberMessage") as? Int
        numberSeat = aDecoder.decodeObject(forKey: "numberSeat") as? Int
        numberTerm = aDecoder.decodeObject(forKey: "numberTerm") as? Int
        numberMember = aDecoder.decodeObject(forKey: "numberMember") as? Int
        key = aDecoder.decodeObject(forKey: "key") as? String
        accountName = aDecoder.decodeObject(forKey: "accountName") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(numberMessage, forKey: "numberMessage")
        aCoder.encode(numberSeat, forKey: "numberSeat")
        aCoder.encode(numberTerm, forKey: "numberTerm")
        aCoder.encode(numberMember, forKey: "numberMember")
        aCoder.encode(key, forKey: "key")
        aCoder.encode(accountName, forKey: "accountName")
    }
    
    static func saveNotice(noice: Notice) {
        let encodeData = NSKeyedArchiver.archivedData(withRootObject: noice)
        UserDefaults.standard.set(encodeData, forKey: "myNotice")
    }
    
    static func getNotice() -> Notice {
        if let data = UserDefaults.standard.data(forKey: "myNotice"),
            let myNotice = NSKeyedUnarchiver.unarchiveObject(with: data) as? Notice {
            return myNotice
        }
        let myNotice = Notice(numberMessage: 0, numberSeat: 0, numberTerm: 0, numberMember: 0, key: "", account: "")
        return myNotice
    }
    
}
