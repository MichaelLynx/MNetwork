//
//  MCommonValue.swift
//  MNetwork
//
//  Created by lynx on 18/1/2021.
//  Copyright © 2021 Lynx. All rights reserved.
//

import UIKit

class MCommonValue: NSObject {
    static let shared = MCommonValue()
    
    var isDebugServer: Bool {
        get {
            return STUserDefault.bool(forKey: "isDebugServer")
        }
        set {
            STUserDefault.set(newValue, forKey: "isDebugServer")
        }
    }
    
}
