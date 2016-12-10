//
//  Constants.swift
//  XmasDating
//
//  Created by THANH LEVAN on 2016/12/10.
//  Copyright © 2016年 THANH LEVAN. All rights reserved.
//

import Foundation
//import Alamofire

//class XmasDating {
//    static let url="http://133.242.226.127:2345"
//    static let user_url = url + "/user"
//    static let user_email_url = user_url + "/email"
//    static let user_email_reg = user_url + "/reg-email"
//
//    static func user_info(email: String){
//        request(XmasDating.user_email_url + "/\(email)").responseJSON { (res) in
//            debugPrint(res)
//            if var json = res.result.value as? [String: Any],
//                let exists = json["exists"] as? Bool {
//                if !exists {
//                    //新規ユーザー登録
//                    json["EMAIL"] = email
//                    XmasDating.registerUser(data: json)
//                }
//            }
//        }
//    }
//
//    static func registerUser(data : Dictionary<String, Any>){
//        print(data)
//        request(self.user_email_reg, method: .post, parameters: data).responseJSON { (res) in
//            debugPrint(res)
//            if var json = res.result.value as? [String: Any],
//                let isNewUser = json["isNewUser"] as? Bool {
//
//                if !isNewUser {
//                    //go to select screen
//
//                }else{
//                    // go to photo selections
//
//                }
//            }
//        }
//    }
//
//}

func writeUserInfo(data : Dictionary<String, Any>){
    
    let text = JSON(data).description
    
    if let path = getUserJsonFilePath() {
//                try! FileManager.default.removeItem(at: path)
        if FileManager.default.fileExists(atPath: path.absoluteString) {
            print("exists")
            try! FileManager.default.removeItem(at: path)
        }
        //writing
        do {
            try text.write(to: path, atomically: true, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}
        
    }
}

func getUserInfo(key: String?) -> JSON {
    
    if let path = getUserJsonFilePath() {
        
        //reading
        do {
            let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
            print(text2)
            if let k = key{
                return JSON.parse(text2)[k]
            }
            return JSON.parse(text2)
        }
        catch {/* error handling here */
            return JSON.null
        }
    }
    
    return JSON.null
    
}

func getUserJsonFilePath() -> URL? {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let path =  dir.appendingPathComponent("user.json")
        print(path)
        return path
    }
    return nil
}

