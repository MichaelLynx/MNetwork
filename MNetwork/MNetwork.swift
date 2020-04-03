//
//  MNetwork.swift
//  MNetwork
//
//  Created by Lynx on 03/04/2020.
//  Copyright © 2020 Lynx. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

typealias SuccessCallBack = ((_ result:[String: Any]) -> ())?
typealias FailureCallBack = ((_ error: Error) -> ())?

enum APIURL {
    static var baseURL = "http://mobile.ximalaya.com"
    
    //path
    static var recommendList = "/discovery-firstpage/v2/explore/ts-1532411485052"
    
    //static var <#content#> = "<#content#>"
}

//From alamofire.
class MNetwork: NSObject {
    
    private static var headers: HTTPHeaders {
        let headers:HTTPHeaders = [:]
        //headers["<#content#>"] = <#content#>
        
        return headers
    }
    
    /// 网络请求
    ///
    /// - Parameters:
    ///   - url: 各个接口的url
    ///   - methodType: 请求方式
    ///   - parameters: 请求参数
    ///   - isNestedData: 是否为嵌套型字典（是则使用Json，否则使用键值对）
    ///   - useBaseUrl: 是否使用基础URL
    ///   - successCallBack: 请求成功回调，可选
    ///   - failureCallBack: 失败回调，可选
    static func request(url:String, methodType: HTTPMethod = .get, parameters:[String:Any] = [:], isNestedData :Bool = false, useBaseUrl:Bool = true,file: String = #file,lineNum: Int = #line, successCallBack:SuccessCallBack = nil, failureCallBack: FailureCallBack = nil) {
        var fullURL = url
        if useBaseUrl {
            fullURL = APIURL.baseURL + url
        }
        let mutableParameters = getFullParameters(parameters: parameters, url: url)
        let encoding: ParameterEncoding = isNestedData ? JSONEncoding.default : URLEncoding.default
        
        Alamofire.request(fullURL, method: methodType, parameters: mutableParameters, encoding: encoding, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                if let dict = json as? [String:Any] {
                    if let successCallBack = successCallBack {
                        successCallBack(dict)
                    }
                }
                
            case .failure(let error):
                print("错误信息：\(error)")
                #if DEBUG
                let fileName = NSString(string: file).lastPathComponent
                print("---\(fileName):(\(lineNum))***请求错误***\n错误描述:\((error as NSError).description)")
                #endif
            }
        }
    }
    
    private static func getFullParameters(parameters:[String:Any], url:String) -> [String:Any] {
        var mutableParameters = [String: Any]()
        
        switch url {
        case APIURL.recommendList:
            mutableParameters = [
                "device":"iPhone",
                "appid":0,
                "categoryId":-2,
                "channel":"ios-b1",
                "code":"43_310000_3100",
                "includeActivity":true,
                "includeSpecial":true,
                "network":"WIFI",
                "operator":3,
                "pullToRefresh":true,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            
        default:
            break
        }
        mutableParameters += parameters
        
        return mutableParameters
    }
}

func += <KeyType, ValueType> ( left: inout Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}
