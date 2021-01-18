//
//  NetWorkParameter.swift
//  MagicCube
//
//  Created by lynx on 18/1/2021.
//  Copyright © 2021 Lynx. All rights reserved.
//

import UIKit
import Alamofire

class NetWorkParameter: NSObject {
    
    var methodType : HTTPMethod = .post
    var url : String = ""
    var parameters : [String : Any] = [:]
    var isNestedData : Bool = false
    var useBaseUrl : Bool = false
    var file : String = "0"
    var lineNum : Int = 0
    var successCallBack : ((_ result:[String: Any]) -> ())?
    var failureCallBack : ((_ error: Error) -> ())?
    
}
