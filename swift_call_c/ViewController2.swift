//
//  ViewController2.swift
//  swift_call_c
//
//  Created by john2 on 2017/6/20.
//  Copyright © 2017年 haha. All rights reserved.
//

import UIKit

class ViewController2: UIViewController,UITableViewDataSource,UITableViewDelegate{

    var number_data_array:[Int]!
    var name_data_array:[String]!
    var score_data_array:[Int]!
    var picture_data_array:[UIImage]!
    
    @IBOutlet var update_button: UIButton!
    
    @IBOutlet var delete_button: UIButton!
    
    @IBOutlet var table: UITableView!
    
    
    
    var choose_row:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////////從sqlite資料庫拉出資料給資料陣列們
        number_data_array = get_numbers_from_db("number") as! [Int]
        name_data_array = get_strings_from_db("name") as! [String]
        score_data_array = get_numbers_from_db("score") as! [Int]
        picture_data_array = get_pictures_from_db("picture") as! [UIImage]
        
        self.table.dataSource = self
        self.table.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        ////////清空
        number_data_array = nil
        name_data_array = nil
        score_data_array = nil
        picture_data_array = nil
        
        ////////從sqlite資料庫拉出資料給資料陣列們
        number_data_array = get_numbers_from_db("number") as! [Int]
        name_data_array = get_strings_from_db("name") as! [String]
        score_data_array = get_numbers_from_db("score") as! [Int]
        picture_data_array = get_pictures_from_db("picture") as! [UIImage]
        
        self.table.reloadData()
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let des:InsertViewController = segue.destination as! InsertViewController
        des.saved = "更新資料"
        
        self.update_button.isEnabled = false
        self.delete_button.isEnabled = false
        
        des.pass_name = name_data_array[self.choose_row]
        des.pass_number = String(number_data_array[self.choose_row])
        des.pass_score = "\(score_data_array[self.choose_row])"
        des.pass_picture = picture_data_array[self.choose_row]
    }
    

    //MARK: -    以下是畫面上Target-Action函數群
    
    @IBAction func insert(_ sender: Any) {
        
        
        
        self.performSegue(withIdentifier: "handle", sender: sender)
        
        
    }
    
    
    @IBAction func update(_ sender: Any) {
        
        self.performSegue(withIdentifier: "handle", sender: sender)
    }
    
    
  
    @IBAction func remove(_ sender: Any) {
    }
    
    
    //MARK: -    以下是UIViewController扮演UITableViewDelegate角色的函數群

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("你選了第\(indexPath.row  + 1)個列")
        choose_row = indexPath.row
        self.update_button.isEnabled = true
        self.delete_button.isEnabled = true
    }
    
    
    
    //MARK: -    以下是UIViewController扮演UITableViewDataSource角色的函數群
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return number_data_array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
     
        cell.imageView?.image = picture_data_array[indexPath.row]
        cell.textLabel?.text = "學生學號: No.\(number_data_array[indexPath.row])"
        cell.detailTextLabel?.text = "姓名:\(name_data_array[indexPath.row])   成績:\(score_data_array[indexPath.row])"
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
