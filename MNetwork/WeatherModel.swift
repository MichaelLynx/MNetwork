//
//  WeatherModel.swift
//  MNetwork
//
//  Created by lynx on 18/1/2021.
//  Copyright © 2021 Lynx. All rights reserved.
//

import UIKit
import HandyJSON

struct WeatherModel: HandyJSON {
    var weatherinfo: WeatherInfoModel?
    var isSuccess: Bool {
        get {
            if let cityid = weatherinfo?.cityid, cityid.count > 0 {
                return true
            } else {
                return false
            }
        }
    }
}

struct WeatherInfoModel: HandyJSON {
    var cityid: String?
    var city: String?
    var temp1: String?
    var temp2: String?
    var weather: String?
    var img1: String?
    var img2: String?
    //var ptime: String?
    
    //Example for replacing a key name.
    var time: String?
    mutating func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &time, name: "ptime")
    }
}
