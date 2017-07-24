//
//  InsertViewController.swift
//  swift_call_c
//
//  Created by john2 on 2017/7/5.
//  Copyright © 2017年 haha. All rights reserved.
//

import UIKit

class InsertViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    // MARK: -   以下是全域變數群
    
     var picker:UIImagePickerController!
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var number: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var score: UITextField!
    
    @IBOutlet var caption: UILabel!
    
    
  
    
    var saved:String!
    
    var pass_number:String!
    var pass_name:String!
    var pass_score:String!
    var pass_picture:UIImage!
    
   // MARK: -   以下是UIViewController處理函數群
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
       
        self.caption.text = self.saved
       if caption.text == "更新資料"{
        
           self.number.text = self.pass_number
           self.name.text = self.pass_name
           self.score.text = self.pass_score
           self.photo.image = self.pass_picture
        
        }
        let left_button:UIBarButtonItem = UIBarButtonItem(
            title: "取消",
            style: .plain,
            target: self,
            action: #selector(InsertViewController.go_back(_:))
        )
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = left_button
        
    }
   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -   以下是自訂Target-Action處理函數群
    
    func go_back(_ sender:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func comfirm(_ sender: Any) {
        
        
        if let _ = Int(self.number.text!) {
            
            if "" == self.name.text{
                print("姓名不能為空")
                return
            }
            
            let success = insert_new_record(
                Int(self.number.text!)!,
                self.name.text,
                Int(self.score.text!)!,
                self.photo.image
            )
            
            if(success){
                print("新增成功")
            }else{
                print("新增失敗")
            }

            
            
            
            
        }else{
            
            print("號碼不能為空或數字以外的字元")
            return
        }
        
        
        
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func take_picture(_ sender: Any) {
        
       
        picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        //picker.cameraDevice = .rear
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    
    // MARK: -   以下是 UIImagePickerControllerDelegate的處理函數群
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        self.photo.image = UIImage(named: "cancel")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let pic:UIImage =  info[UIImagePickerControllerOriginalImage] as! UIImage
        self.photo.image = pic
         picker.dismiss(animated: true, completion: nil)
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
