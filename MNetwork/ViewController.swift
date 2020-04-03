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
        setData()
    }
    
    func setData() {
        MNetwork.request(url: APIURL.recommendList, successCallBack: { (result) in
            //反序列化
            if let model = HomeRecommendModel.deserialize(from: result) {
                print(model)
                //序列化
                print("\n序列化：")
                print(model.toJSON()!)
            }
        }) { (error) in
            print("error:\(error)")
        }
    }
}
