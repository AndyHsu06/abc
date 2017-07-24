//
//  ViewController.swift
//  swift_call_c
//
//  Created by john2 on 2017/6/20.
//  Copyright © 2017年 haha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var account: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "haha"
        
        let data_in_home = NSHomeDirectory() + "/Documents/data.sqlite"
        print("data_in_home----->\(data_in_home)")
        let data_in_bundle = Bundle.main.path(forResource: "data", ofType: "sqlite")!
        print("data_in_bundle----->\(data_in_bundle)")
        
        
         let manager = FileManager.default
         if !manager.fileExists(atPath: data_in_home){
              print("第一次執行！！複製資料庫到home")
              do{
                    try manager.copyItem(atPath: data_in_bundle, toPath: data_in_home)
              }catch{
                    print(error)
              }
         }
        
        

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: Any) {
        
        var is_member:Bool
        
        is_member = has_this_guy(self.account.text!, self.password.text!)
        
        if is_member{
            print("是管理員");
            
            self.performSegue(withIdentifier: "go", sender: sender)
            
            
        }else{
            print("不是管理員")
        }
        
        //self.account.resignFirstResponder()
        //self.password.resignFirstResponder()
        
    }

    @IBAction func cancel(_ sender: Any) {
        
        self.account.text = ""
        self.password.text = ""
        
        self.account.resignFirstResponder()
        self.password.resignFirstResponder()
    }
}

