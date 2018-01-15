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
    
    var content = ""
    var time = ""
    
    init(json: JSON) {
        content = json["voucher_name"].stringValue
        let timeDate = json["cre_date"].stringValue
        let date = Date.convertToDateWith(timeInt: timeDate, withFormat: "yyyy-MM-dd'T'HH-mm-ss")
        let timeMessage = Date.convert(date: date!, toString: "MM/dd HH:mm")
        self.time = timeMessage
    }
}

extension Date {
    static func convertToDateWith(timeInt: String, withFormat: String) -> Date? {
        let dateFomater = DateFormatter()
        dateFomater.dateFormat = withFormat
        let date = dateFomater.date(from: timeInt)
        return date
    }

    static func convert(date: Date, toString timeOut: String) -> String {
        let dateFomater = DateFormatter()
        dateFomater.dateFormat = timeOut
        let dateString = dateFomater.string(from: date)
        return dateString
    }
}
