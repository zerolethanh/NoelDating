//
//  CoupleChoosePhotoViewController.swift
//  Dating
//
//  Created by THANH LEVAN on 2016/12/09.
//  Copyright © 2016年 THANH LEVAN. All rights reserved.
//

import UIKit

class CoupleChoosePhotoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imgPk = UIImagePickerController()
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPk.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func choose(_ sender: Any) {
        imgPk.sourceType = .photoLibrary
        present(imgPk, animated: true, completion: nil
        )
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        imgView.image = info["UIImagePickerControllerOriginalImage"] as! UIImage?
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func takePhoto(_ sender: Any) {
        imgPk.sourceType = .camera
        present(imgPk, animated: true, completion: nil
        )
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
