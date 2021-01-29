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
    static var disBaserURL = "http://www.weather.com.cn"
    static var devBaseURL = "http://www.weather.com.cn"
    
    #if DEBUG
    static var baseURL = devBaseURL
    #else
    static var baseURL = disBaserURL
    #endif
    
    //path
    ///Weather
    static var queryWeather = "/data/cityinfo/101010100.html"
    
    //static var <#content#> = "<#content#>"
}

class MNetwork: NSObject {
    static let lastNetWorkRequestParamers = MNetWorkParameter()
    
    private static var headers: HTTPHeaders {
        let headers:HTTPHeaders = [:]
        //headers["<#content#>"] = <#content#>
        
        return headers
    }
    
    static var isDebugServer: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isDebugServer")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isDebugServer")
        }
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
        
        AF.request(fullURL, method: methodType, parameters: mutableParameters, encoding: encoding, headers: headers).responseJSON { (response) in
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
    
    ///Add the default parameters.
    private static func getFullParameters(parameters:[String:Any], url:String) -> [String:Any] {
        var mutableParameters = [String: Any]()
        
        mutableParameters += parameters
        
        return mutableParameters
    }
    
    ///Request again after failed.
    private static func recoverLastNetWorkRequest() {
        let methodType = lastNetWorkRequestParamers.methodType
        let url = lastNetWorkRequestParamers.url
        let parameters = lastNetWorkRequestParamers.parameters
        let file = lastNetWorkRequestParamers.file
        let lineNum = lastNetWorkRequestParamers.lineNum
        let isNestedData = lastNetWorkRequestParamers.isNestedData
        let useBaseUrl = lastNetWorkRequestParamers.useBaseUrl
        let successCallBack = lastNetWorkRequestParamers.successCallBack!
        let failureCallBack = lastNetWorkRequestParamers.failureCallBack
        
        MNetwork.request(url: url, methodType: methodType, parameters: parameters, isNestedData: isNestedData, useBaseUrl: useBaseUrl, file: file, lineNum: lineNum, successCallBack: successCallBack, failureCallBack: failureCallBack)
    }
    
    ///Assign  the value to the baseURL again when the app activates.
    static func initBaseURL() {
        #if DEBUG
        if MNetwork.isDebugServer {
            APIURL.baseURL = APIURL.devBaseURL
        } else {
            APIURL.baseURL = APIURL.disBaserURL
        }
        #endif
    }
    
    static func switchBaseURL() {
        MNetwork.isDebugServer = !MNetwork.isDebugServer
        var message = "当前为：正式服"
        if MNetwork.isDebugServer {
            APIURL.baseURL = APIURL.devBaseURL
            message = "当前为：开发服"
        } else {
            APIURL.baseURL = APIURL.disBaserURL
            message = "当前为：正式服"
        }
        print(message)
    }
}

func += <KeyType, ValueType> ( left: inout Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}
