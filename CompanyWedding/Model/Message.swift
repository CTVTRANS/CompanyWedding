//
//  Message.swift
//  CompanyWedding
//
//  Created by le kien on 11/17/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Message {

    var content = ""
    var isReaded = false
    init() {}
    init(json: JSON) {
        content = json[""].string!
        isReaded = json[""].int! == 0 ? true : false
    }
}
