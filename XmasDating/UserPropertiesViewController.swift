//
//  UserPropertiesViewController.swift
//  XmasDating
//
//  Created by THANH LEVAN on 2016/12/10.
//  Copyright © 2016年 THANH LEVAN. All rights reserved.
//

import UIKit
import Alamofire

class UserPropertiesViewController: UIViewController ,
UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var selfImageView: UIImageView!
    @IBOutlet weak var propertiesTable: UITableView!
    
    var userData : JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        userData = getUserInfo(key: "user")
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        showImage()
    }
    func showImage(){
        let url = URL(string: get(key : "IMAGE"))
        let data = try! Data(contentsOf: url!)
        selfImageView.image = UIImage(data: data)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if indexPath.row == 0 {
        cell.textLabel?.text = "AGE"
        cell.detailTextLabel?.text = userData["AGE"].stringValue
        } else if indexPath.row == 1{
            cell.textLabel?.text = "GENDER"
            cell.detailTextLabel?.text = userData["GENDER"].stringValue
        }
        
        return cell
        
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
