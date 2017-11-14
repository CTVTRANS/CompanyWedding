//
//  LKCrypto.swift
//  CompanyWedding
//
//  Created by le kien on 11/8/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

class LKCrypto {

}

extension String {
    public func md5() -> String {
        let data = self.data(using: .utf8)!
        var digest = Data(count: Int(CC_MD5_DIGEST_LENGTH))

        _ = digest.withUnsafeMutableBytes {digestBytes in
            data.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(data.count), digestBytes)
            }
        }
        let md5Hex =  digest.map { String(format: "%02hhx", $0) }.joined()
        return md5Hex
    }
    
    public func sha1() -> String {
        let data = self.data(using: .utf8)!
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}
