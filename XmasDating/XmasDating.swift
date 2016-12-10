//
//  Constants.swift
//  XmasDating
//
//  Created by THANH LEVAN on 2016/12/10.
//  Copyright © 2016年 THANH LEVAN. All rights reserved.
//

import Foundation


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

func writeSetting(data : Dictionary<String, Any>){
    
    let text = JSON(data).description
    
    if let path = getSettingJsonFilePath() {
        
        if FileManager.default.fileExists(atPath: path.absoluteString) {
            try! FileManager.default.removeItem(at: path)
        }
        //writing
        do {
            try text.write(to: path, atomically: true, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}
        
    }
}

func setting(key:String?) -> JSON
{
    
    if let path = getUserJsonFilePath() {
        
        //reading
        do {
            let t = try String(contentsOf: path, encoding: String.Encoding.utf8)
            let json = JSON.parse(t)
            
            if let k = key {
                return json[k]
            }
            return json
            
        }
        catch {/* error handling here */
            return JSON.null
        }
    }
    
    return JSON.null
    
}


func getUserInfo(key: String?) -> JSON {
    
    if let path = getUserJsonFilePath() {
        
        //reading
        do {
            let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
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
        return path
    }
    return nil
}
func getSettingJsonFilePath() -> URL? {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let path =  dir.appendingPathComponent("setting.json")
        return path
    }
    return nil
}

func user(key:String)->String
{
    return getUserInfo(key: "user")[key].stringValue
}
func EMAIL() -> String {
    return user(key: "EMAIL")
}

func save(key:String,value:String) {
    UserDefaults.standard.set(value, forKey: key)
    UserDefaults.standard.synchronize()
}
func get(key:String) -> String {
    return UserDefaults.standard.string(forKey: key)!
}
func _token()  -> String {
    return get(key: "_token")
}

extension String {
    func toData() -> Data {
        return self.data(using: String.Encoding.utf8)!
    }
}

//func saveUserImageURL(imageURL : String){
//    UserDefaults.standard.set(imageURL, forKey: "IMAGE")
//    UserDefaults.standard.synchronize()
//}
//
//func getUserImageURL() -> String {
//    return UserDefaults.standard.string(forKey: "IMAGE")!
//}



