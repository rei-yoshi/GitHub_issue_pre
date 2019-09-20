//
//  ViewController.swift
//  GitHub_issue_pre
//
//  Created by 吉田れい on 2019/08/29.
//  Copyright © 2019 吉田れい. All rights reserved.
//

import UIKit

public class ViewController : UIViewController {
    
    @IBOutlet weak var IssueNumber_textField : UITextField?
    @IBOutlet weak var searchIssue_Button: UIButton?
    
    
    
    
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //issue_Searchを押した時のメソッド
    @IBAction func searchIssue_Button (_ sender : UIButton){
    }
    
    
    //セグエの処理
    //textFieldの入力値をsingleViewController.Swiftの変数に値渡しを実行した
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let issues_number : Int?  = Int(IssueNumber_textField!.text!)
        
        if segue.identifier == "nextViewController" {
            guard issues_number != nil else {return}
            let nextViewController = segue.destination as! singleissue_ViewController
            nextViewController.issues_number = issues_number
            
        }
    }
        
        
    
    //backボタンの設置
    //storyboard refarenseのbackボタンに
    @IBAction func back(segue : UIStoryboardSegue){
        
    }

}
