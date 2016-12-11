//
//  CoupleChoosePhotoViewController.swift
//  Dating
//
//  Created by THANH LEVAN on 2016/12/09.
//  Copyright © 2016年 THANH LEVAN. All rights reserved.
//

import UIKit
import Alamofire

class CoupleChoosePhotoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imgPk = UIImagePickerController()
//    var imgURL : URL!
    var imgData : Data!
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPk.delegate = self
        if let img = imgView.image {
            self.imgData = UIImagePNGRepresentation(img)
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        imgView.layer.cornerRadius = 10;
        imgView.clipsToBounds = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func choose(_ sender: Any) {
        imgPk.sourceType = .photoLibrary
        present(imgPk, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        imgURL = info["UIImagePickerControllerReferenceURL"] as! URL
        self.imgView.image = info["UIImagePickerControllerOriginalImage"] as! UIImage?
        self.imgData = UIImagePNGRepresentation((imgView.image)!)
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func takePhoto(_ sender: Any) {
        imgPk.sourceType = .camera
        present(imgPk, animated: true, completion: nil)
    }
    
    @IBAction func upload(_ sender: Any) {
        print(#function)
        print(EMAIL())
        print(_token())
        print((self.imgData)!)
        Alamofire.upload(
            multipartFormData: {
                [weak self] multipartFormData in
//                multipartFormData.append(_token().toData(),withName: "_token")
                multipartFormData.append(EMAIL().toData(), withName: "EMAIL")
                multipartFormData.append((self?.imgData)!, withName: "photo", fileName: "photo", mimeType:"image/png")
                
        },
            to: XmasDating.photo_upload,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { [weak self] response in
                        if let json = response.result.value {
                            print(json)
                            writeUserInfo(data: (json as! Dictionary<String, Any>))
                            writeSetting(data: (json as! Dictionary<String, Any>))
                            let j = JSON(json)
                            
                            if j["uploaded"].intValue == 1 || j["faceInfoCount"].intValue == 1 {
                                save(key: "IMAGE", value: j["user"]["IMAGE"].stringValue)
                                self?.performSegue(withIdentifier: "toPropertiesUserController", sender: nil)
                            }else{
                             self?.showAlert()
                            }
                            
                        }else{
                            self?.showAlert()
                        }
                        
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
    }
    func showAlert(msg:String = "顔の認識ができません") {
        let al = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        al.addAction(ok)
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
