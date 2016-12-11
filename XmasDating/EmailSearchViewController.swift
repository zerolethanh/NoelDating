
//
//  EmailSearchViewController.swift
//  XmasDating
//
//  Created by THANH LEVAN on 2016/12/10.
//  Copyright © 2016年 THANH LEVAN. All rights reserved.
//

import UIKit
import Alamofire

class EmailSearchViewController: UIViewController ,
UICollectionViewDelegate, UICollectionViewDataSource {

    var userList : JSON = [] {
        didSet {
//            print(userList)
            userListCollectionView.reloadData()
        }
    }
    var selectedUser : JSON  = []
    
    @IBOutlet weak var selectedUserImgView: UIImageView!
    
    @IBOutlet weak var userListCollectionView: UICollectionView!
    @IBOutlet weak var selectedCollectionView: UICollectionView!
    
    @IBOutlet weak var selfImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestUserList()
        requestSelfImage()
    }
    func requestSelfImage(){
        let url = URL(string: user(key: "IMAGE"))
        if let validURL = url {
            let data = try! Data(contentsOf: validURL)
            selfImageView.image = UIImage(data: data)
        }else{
            print("IMAGE URL IS NOT VALID")
        }
    }
    func requestUserList(){
        request(XmasDating.photo_sug, method: .get, parameters: ["EMAIL":EMAIL()])
            .responseJSON { [weak self](res) in
                debugPrint(res)
                self?.userList = res.result.json()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(userList.count == 0){
            return 1
        }
        return userList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserListCollectionViewCell
        
        cell.imgView.fromURL(url: userList[indexPath.row][
            "IMAGE"].stringValue)
        
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath)
//        print(userList[indexPath.item])
        selectedUser = userList[indexPath.item]
        
        selectedUserImgView.fromURL(url: selectedUser["IMAGE"].stringValue)
        
    }
    @IBAction func invite(_ sender: Any) {
        request(XmasDating.req_send, method: .get, parameters: [
            "from_email" : EMAIL(),
            "to_email" : selectedUser["EMAIL"].stringValue
            ])
        .responseJSON { (res) in
            print(res.result.json())
            //invite 完了
            let j = res.result.json()
            
            self.afterRequestSendSuccess(j)
        
        }
    }
    
    func afterRequestSendSuccess(_ j: JSON){
        let al = UIAlertController(title: "Requests", message: "Request was sent. \n Please wait for Accept", preferredStyle: .alert)
        
        let ac = UIAlertAction(title: "Is Accepted?", style: .default) { (action) in
            
            request(XmasDating.req_is_accepted, method: .get, parameters: [ "id": j["id"].stringValue ])
            .responseJSON(completionHandler: { [weak self] (res) in
                debugPrint(res)
                //request accepted json
                let r = res.result.json()
                
                //NOT accepted then show this alert again
                if r["accepted"].boolValue == false {
                    self?.afterRequestSendSuccess(j)
                    
                } else {
                    // accepted
                    //toStartDatingViewController
                    self?.performSegue(withIdentifier: "toStartDatingViewController", sender: nil)
                }
                
            })
            

        }
        
        let no = UIAlertAction(title: "I don't want to wait more.", style: .destructive)
        
        al.addAction(ac)
        al.addAction(no)
        
        present(al, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pull(_ sender: Any) {
        request(XmasDating.req_pull, method: .get, parameters: [
            "to_email": EMAIL()])
            .responseJSON {
                [weak self] (res) in
                let j = res.result.json()
                
                print(j)
                let numberOfRequests = j["numberOfRequests"].intValue
                if numberOfRequests > 0 {
                    
                    self?.showPulledRequest(j)
                }
        }
    }
    
    func showPulledRequest(_ requestJson: JSON){
        let al = UIAlertController(title: "Requests", message: "FROM:" + requestJson["from_emails"][0].stringValue, preferredStyle: .alert)
        
        let ac = UIAlertAction(title: "Accept", style: .default) { (action) in
            print(action)
            
            //toStartDatingViewController
            self.performSegue(withIdentifier: "toStartDatingViewController", sender: nil)
        }
        
        let no = UIAlertAction(title: "NO", style: .destructive)
        
        al.addAction(ac)
        al.addAction(no)
        
        present(al, animated: true, completion: nil)
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

extension UIImageView {
    func fromURL(url: String?){
        if let validURLString = url {
            if let validURL = URL(string: validURLString){
                self.image = UIImage(data: try! Data(contentsOf: validURL))
            }
        }
    }
}
