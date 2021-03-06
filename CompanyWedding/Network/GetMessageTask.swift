//
//  GetMessageTask.swift
//  CompanyWedding
//
//  Created by le kien on 11/29/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetMessageTask: LKNetwork {
    var username: String!
    let key: String!
    
    init(username: String, key: String) {
        self.username = username
        self.key = key
    }
    
    override func path() -> String {
        return getFactoryMessage
    }
    
    override func parameters() -> [String: Any] {
        return ["id": username, "k": "ce97e1dce2857e6dff98d61c0e49b23d5cabc2d6"]
    }
    
    override func method() -> HTTPMethod {
        return .GET
    }
    
    override func dataWithResponse(_ response: Any) -> Any {
        var listMessage = [MessageLog]()
        if let jsons = response as? [JSON] {
            for json in jsons {
                let message = MessageLog.decodeJson(json: json)
                if message.owner == "W1" || message.owner == "W3" {
                    listMessage.append(message)
                }
            }
        }
        return listMessage
    }
}
