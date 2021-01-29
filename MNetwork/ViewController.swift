//
//  ViewController.swift
//  MNetwork
//
//  Created by Lynx on 03/04/2020.
//  Copyright © 2020 Lynx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupData()
    }
    
    func setupData() {
        MNetwork.request(url: APIURL.queryWeather, successCallBack: { (result) in
            //反序列化/deserialization
            if let model = WeatherModel.deserialize(from: result) {
                print("result:\n\(result)")
                print("deserialized model:\n\(model)")
                //序列化/serialization
                print("serialization:")
                print(model.toJSON()!)
            }
        }) { (error) in
            print("error:\(error)")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        MNetwork.switchBaseURL()
        print("当前服务器域名/Current host：" + APIURL.baseURL)
    }
}
