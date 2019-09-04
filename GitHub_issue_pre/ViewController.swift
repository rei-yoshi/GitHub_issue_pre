//
//  ViewController.swift
//  GitHub_issue_pre
//
//  Created by 吉田れい on 2019/08/29.
//  Copyright © 2019 吉田れい. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var IssueNumber_textField : UITextField!
    @IBOutlet weak var searchIssue_Button: UIButton!
    
    //textFieldの数値を保存用
    var textField_Number = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //セグエの処理
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        if segue.identifier == "toView2" {
            let nextView = segue.destination as! singleissue_ViewController
            
            nextView.argString = IssueNumber_textField.text!
        }
    }
    //issue_Searchを押した時のメソッド
    @IBAction func searchIssue_Button (_ sender : UIButton){
    }
}
