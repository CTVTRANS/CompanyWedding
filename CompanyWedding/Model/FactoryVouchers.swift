//
//  FactoryVouchers.swift
//  CompanyWedding
//
//  Created by le kien on 11/30/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FactotyVoucher {
    
    var content: String = ""
    var time: String = ""
    
    init(json: JSON) {
        content = json["voucher_name"].stringValue
        let timeDate = json["cre_date"].stringValue
        let date: String! = timeDate.components(separatedBy: "T")[0]
        let time: String! = timeDate.components(separatedBy: "T")[1]
        let index4 = timeDate.index(timeDate.startIndex, offsetBy: 4)
        let index5 = timeDate.index(timeDate.startIndex, offsetBy: 5)
        self.time = "\(date[index5...])/\(time[...index4])"
    }
}
