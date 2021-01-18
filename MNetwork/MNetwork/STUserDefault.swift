//
//  STUserDefault.swift
//  MagicCube
//
//  Created by lynx on 18/1/2021.
//  Copyright © 2021 Lynx. All rights reserved.
//

import UIKit

class STUserDefault: NSObject {
    
    private static let userDefault = UserDefaults.standard
    
    static func string(forKey defaultName: String) -> String {
        let str = userDefault.string(forKey: defaultName)
        return str ?? ""
    }
    
    static func integer(forKey defaultName: String) -> Int {
        let num = userDefault.integer(forKey: defaultName)
        return num
    }
    
    static func float(forKey defaultName: String) -> Float {
        let num = userDefault.float(forKey: defaultName)
        return num
    }
    
    static func bool(forKey defaultName: String) -> Bool {
        let bool = userDefault.bool(forKey: defaultName)
        return bool 
    }
    
    static func dictionary(forKey defaultName: String) -> [String:Any] {
        let str = userDefault.dictionary(forKey: defaultName)
        return str ?? [:]
    }
    
    static func array(forKey defaultName: String) -> [Any]{
        let array = userDefault.array(forKey: defaultName)
        return array ?? []
    }
    
    static func set <T>(_ value: T, forKey defaultName: String) {
        userDefault.set(value, forKey: defaultName)
        synchronize()
    }
    
    static func removeObject(forKey key:String) {
        userDefault.removeObject(forKey: key)
        synchronize()
    }
    
    static func synchronize() {
        userDefault.synchronize()
    }
}
