//
//  EmailViewController.swift
//  XmasDating
//
//  Created by THANH LEVAN on 2016/12/10.
//  Copyright © 2016年 THANH LEVAN. All rights reserved.
//

import UIKit
import Alamofire

class EmailViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func start(_ sender: Any) {
        let email = emailField.text;
        if (email == nil) || (email?.isEmpty)! {
            return
        }
        XmasDating.user_info(email: email!){
            [weak self]user_info in
            
            writeUserInfo(data: user_info)
            save(key: "_token", value: user_info["_token"] as! String)
            
            
            if let isNewUser = user_info["isNewUser"] as? Bool {
                
                if !isNewUser {
                    //go to select screen
            
                    self?.performSegue(withIdentifier: "isNotNewUser", sender: nil)
                }else{
                    // go to new user photo selections
                    self?.performSegue(withIdentifier: "isNewUser", sender: nil)
                }
            }
            
        }
        
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
class XmasDating {
    static let url="http://133.242.226.127:2345"
    static let user_url = url + "/user"
    static let user_email_url = user_url + "/email"
    static let user_email_reg = user_url + "/reg-email"
    static let photo_upload = url + "/photo/upload"
    static func user_info(email: String, callBack: @escaping (_ user_info: Dictionary<String, Any>) -> () ){
        request(XmasDating.user_email_url + "/\(email)").responseJSON { (res) in
//            debugPrint(res)
            if var json = res.result.value as? [String: Any],
                let exists = json["exists"] as? Bool {
                if !exists {
                    //新規ユーザー登録
                    json["EMAIL"] = email
                    XmasDating.registerUser(data: json, callBack: callBack)
                }else{
                    callBack(json)
                }
                
            }
        }
    }
    
    static func registerUser(data : Dictionary<String, Any>,  callBack: @escaping (_ user_info: Dictionary<String, Any>) -> ()){
//        print(data)
        request(self.user_email_reg, method: .post, parameters: data).responseJSON { (res) in
//            debugPrint(res)
            if let json = res.result.value as? [String: Any]{
                print(json)
                callBack(json)
            }
        }
    }
    
}

//class  User {
//    static let isNewUser = false
//    static let user :Dictionary<String, Any>! = nil
//    static let exists = false
//    static let _token : String! = nil
//    
//    static func infoFromUserDefaults(){
//        
//    }
//    static func saveToUserDefaults(data: Dictionary<String,Any>) {
//        let d = UserDefaults.standard
//        d.set(data["isNewUser"], forKey: "isNewUser")
//        d.setValue(data["user"], forKey: "user")
//        d.set(data["exists"], forKey: "exists")
//        d.set(data["_token"], forKey: "_token")
//        d.synchronize()
//    }
//    
//    static func user(key : String?) -> Any? {
//        let d = UserDefaults.standard
//        let user = d.dictionary(forKey: "user")
//        if key == nil {
//            return user
//        }
//        return user?[key!]
//    }
//    
//    static func token()-> String {
//        let d = UserDefaults.standard
//        return d.string(forKey: "_token")!
//    }
//}
