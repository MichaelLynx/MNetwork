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
    static var adListURL = "http://adse.ximalaya.com"
    
    //path
    static var recommendList = "/discovery-firstpage/v2/explore/ts-1532411485052"
    static var recommendForYouList = "/mobile/discovery/v4/recommend/albums"
    static var recommendAdList = "/ting/feed/ts-1532656780625"
    static var guessYouLikeMoreList = "/discovery-firstpage/guessYouLike/list/ts-1534815616591"
    static var changeGuessYouLikeList = "/discovery-firstpage/guessYouLike/cycle/ts-1535167862593"
    static var changePaidCategoryList = "/mobile/discovery/v1/guessYouLike/paidCategory/ts-1535167980873"
    static var changeLiveList = "/lamia/v1/hotpage/exchange"
    static var changeOtherCategory = "/mobile/discovery/v4/albums/ts-1535168024113"
    
    //    static var <#content#> = "<#content#>"
    
}

//From alamofire.
class MNetwork: NSObject {
    
    private static var headers: HTTPHeaders {
        var headers:HTTPHeaders = [:]
        //headers["<#content#>"] = <#content#>
        
        return headers
    }
    
    static func request(url:String, methodType: HTTPMethod = .get, parameters:[String:Any] = [:], isNestedData :Bool = false, useBaseUrl:Bool = true,  successCallBack:SuccessCallBack = nil, failureCallBack: FailureCallBack = nil) {
        var fullURL = url
        if useBaseUrl {
            if url == APIURL.recommendAdList {
                fullURL = APIURL.adListURL + url
            } else {
                fullURL = APIURL.baseURL + url
            }
        }
        
        let mutableParameters = getNewParameters(parameters: parameters, url: url)
        
        var encoding: ParameterEncoding  = URLEncoding.default
        if isNestedData == true  {
            encoding = JSONEncoding.default
        }
        
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
            }
        }
    }
    
    private static func getNewParameters(parameters:[String:Any], url:String) -> [String:Any] {
        
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
            
        case APIURL.recommendForYouList:
            mutableParameters = [
                "device":"iPhone",
                "excludedAlbumIds":"3144231%2C3160816%2C5088879%2C3703879%2C9723091%2C12580785%2C12610571%2C13507836%2C11501536%2C12642314%2C4137349%2C10587045%2C6233693%2C4436043%2C16302530%2C15427120%2C13211141%2C61%2C220565%2C3475911%2C3179882%2C10596891%2C261506%2C7183288%2C203355%2C3493173%2C7054736%2C10728301%2C2688602%2C13048404",
                "appid":0,
                "categoryId":-2,
                "pageId":1,
                "pageSize":20,
                "network":"WIFI",
                "operator":3,
                "scale":3,
                "uid":124057809,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            
        case APIURL.recommendAdList:
            mutableParameters = [
                "device":"iPhone",
                "appid":0,
                "name":"find_native",
                "network":"WIFI",
                "operator":3,
                "scale":3,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970)
            ]
            
        case APIURL.guessYouLikeMoreList:
            mutableParameters = [
                "device":"iPhone",
                "appid":0,
                "inreview":false,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":20,
                "scale":3,
                "uid":124057809,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            
        case APIURL.changeGuessYouLikeList:
            mutableParameters = [
                "device":"iPhone",
                "appid":0,
                "excludedAdAlbumIds":"8258116%2C8601255%2C16514340",
                "excludedAlbumIds":"4169245%2C4156778%2C4078652%2C8601255%2C4177638%2C16514340%2C5993267%2C12201334%2C13089888%2C4310827%2C4792267%2C2912127%2C13403391%2C4193171%2C5411224%2C8258116%2C4323493%2C10829913",
                "excludedRoomIds":"",
                "excludedSpecialIds":"",
                
                "excludedOffset":18,
                "inreview":false,
                "loopIndex":3,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":6,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            
        case APIURL.changePaidCategoryList:
            mutableParameters = [
                "device":"iPhone",
                "appid":0,
                "excludedAdAlbumIds":13616258,
                "excludedOffset":18,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":3,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            
        case APIURL.changeLiveList:
            mutableParameters = [
                "currentRecordIds":"1655918%2C1671613%2C1673030%2C1670774%2C1673082%2C1672407",
                "pageId":1,
                "pageSize":6,
                "device":"iPhone"
            ]
            
        case APIURL.changeOtherCategory:
            mutableParameters = [
                "appid":0,
                "excludedAlbumIds":"7024810%2C8424399%2C8125936",
                "excludedAdAlbumIds":"13616258",
                "excludedOffset":3,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":3,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString
            ]
            //"categoryId"
            
        default:
            break
        }
        
        for (key,value) in parameters {
            mutableParameters[key] = value
        }
        
        return mutableParameters
    }
    
}
