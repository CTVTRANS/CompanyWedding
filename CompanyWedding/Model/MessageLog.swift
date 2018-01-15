//
//  Message.swift
//  CompanyWedding
//
//  Created by le kien on 11/17/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import SwiftyJSON

struct MessageLog {

    var content = ""
    var time = ""
    var owner = ""
    
    static func decodeJson(json: JSON) -> MessageLog {
        var timeMessage = ""
        if let date = Date.convertToDateWith(timeInt: json["MESSAGE_TIME"].stringValue, withFormat: "yyyy-MM-dd'T'HH-mm-ss") {
            timeMessage = Date.convert(date: date, toString: "MM/dd HH:mm")
        }
        return MessageLog(content: json["MESSAGE_CONTENT"].stringValue,
                          time: timeMessage,
                          owner: json["FROM_USER_GROUP"].stringValue
        )
    }
}
