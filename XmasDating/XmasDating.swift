//
//  Constants.swift
//  XmasDating
//
//  Created by THANH LEVAN on 2016/12/10.
//  Copyright © 2016年 THANH LEVAN. All rights reserved.
//

import Foundation
import Alamofire

class XmasDating {
    static let url="http://133.242.226.127:2345"
    static let user_url = url + "/user"
    static let user_email_url = user_url + "/email"
    
    static func user_info(email: String){
        request(XmasDating.user_email_url + "/\(email)").responseJSON(completionHandler: { (res) in
            print(email)
            print(res.result.value!)
        })
    }
}
