//
//  StoryboardHelper.swift
//  CompanyWedding
//
//  Created by le kien on 11/9/17.
//  Copyright © 2017 le kien. All rights reserved.
//

import UIKit

protocol StoryboardHelper {
    static func instance() -> UIViewController
}
protocol MainStoryboard: StoryboardHelper {}
extension MainStoryboard {
    static func instance() -> UIViewController {
        let st = UIStoryboard(name: "Main", bundle: nil)
        return st.instantiateViewController(withIdentifier: String(describing: self.self))
    }
}
