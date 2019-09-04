//
//  singleissue_ViewController.swift
//  GitHub_issue_pre
//
//  Created by 吉田れい on 2019/09/04.
//  Copyright © 2019 吉田れい. All rights reserved.
//

import UIKit
import Alamofire
import Foundation


class singleissue_ViewController: UIViewController {
    
    
    @IBOutlet weak var searchIssue_Button: UIButton!

    @IBOutlet weak var issue_title: UILabel!
    
    //let issues_run = Issue_number()
    //issues_run.issue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let issues_run = Issue_number()
        issues_run.issue()
        
        //UIlabelにtitleとbodyを評しできるように
         issue_title.text = "\(issues_run.title_issues)"
    }
}

//ViewControllerのインスタンスを作成し入力値をget
//それを用いてクエリを指定して検索をかけたい
var temp = ViewController()
var search_number = temp.textField_Number



//basicm認証 成功! 2019/08/31
//アクセス方法に自身で設定したアクセストークンを設定したことで
//ookami_organizationへのアクセス権限を得ることができた

let user = "rei-yoshi"
let password = "rei07041998"
var value_issue:Any = 0
var query_number : Int = 0

//クエリを指定
//ViewControllerクラスから入力値をもらう(issuenum.issue_number)
let ookami_issues_url:String = "https://api.github.com/repos/ookamiinc/ios/issues/\(String(search_number))"

let ookami_issues_url_:String = "https://api.github.com/repos/ookamiinc/ios/issues/4909"

let password1 = "6e3a2ef2616ae8390252391edb8a944b3b6b1c8a"
let credentialData = "\(user):\(password1)".data(using: String.Encoding.utf8)!
let base64Credentials = credentialData.base64EncodedString()
let headers = [
    "Authorization": "Basic \(base64Credentials)",
    "Accept": "application/json",
    "Content-Type": "application/json",
]


//issueの最新のnumberを取得する
class Issue_number {
    
    var title_issues :String = ""
    var body_issues : String  = ""

    
    let issue_title_label = singleissue_ViewController()
    
    //特定のクエリを指定した時のパースを実装したもの
    func issue() {
        Alamofire.request(ookami_issues_url_, method: .get, parameters: nil,encoding: URLEncoding(destination: .queryString), headers: headers) .responseJSON { response in
            
            
            /*
            switch response.result {
            case .success(let value):
                print(value)
                value_issue = value
            //your success code
            case .failure(_):
                print("error")
            }
            */
            
            
            //guard文で書き変え
            //パースすることに成功
            //queryを指定した時に実施する用
            //numberの取得
            struct issues_JSON : Codable {
                var title : String
                var body: String
                var number : Int
                var comments_url : String
            }
            
            
            
            guard let data=response.data else {
                return
            }
            let decorder = JSONDecoder()
            do{
                let task : issues_JSON = try decorder.decode(issues_JSON.self,from : data)
                //issues_JSON型で
                //print(task)
                
                
                
                
                print(task.title)
                print(task.number)
                print(task.body)
                
                print("クエリ設定時parseは成功!!")
                
                for _ in 1...7{
                    print("")
                }
                
                query_number = task.number
                
            }
            catch{
                print(error)
            }
        }
    }
}


//配列型のパースを実施するためのプロトコルを定義
public protocol Decodable {
    init(from decoder: Decoder) throws
}



