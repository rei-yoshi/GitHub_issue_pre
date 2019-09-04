//
//  ViewController.swift
//  GitHub_issue_pre
//
//  Created by 吉田れい on 2019/08/29.
//  Copyright © 2019 吉田れい. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var IssueNumber_specification: UITextField!
    @IBOutlet weak var searchIssue_Button: UIButton!
    
    //textFieldの数値を保存用
    var textField_Number = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //issue_Searchを押した時のメソッド
    @IBAction func searchIssue_Button (_ sender : UIButton){
        
        //singleissue.Swiftでも使用する
        textField_Number = IssueNumber_specification.text!
        
        //let issue_number = Int(textField_Number)!
        
        //初期化
        IssueNumber_specification.text = ""
        
    }
}
