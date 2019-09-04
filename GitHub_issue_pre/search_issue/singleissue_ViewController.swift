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
    
    var argString = ""
    
    @IBOutlet weak var searchIssue_Button: UIButton!
    @IBOutlet weak var issue_title: UILabel!
    
    
    //let issues_run = Issue_number()
    //issues_run.issue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let issues_run = singleissue_ViewController()
        issues_run.issue()
    }
    //特定のクエリを指定した時のパースを実装したもの
    func issue() {
        
        //basicm認証 成功! 2019/08/31
        //アクセス方法に自身で設定したアクセストークンを設定したことで
        //ookami_organizationへのアクセス権限を得ることができた
        //ViewControllerクラスから入力値をもらう(issuenum.issue_number)->クエリの指定
        let ookami_issues_url : String = "https://api.github.com/repos/ookamiinc/ios/issues/\(argString)"
        let user = "rei-yoshi"
        let password1 :String = "7a04f18703bab7abf9b589644ee1bc0c82af3d58"
        let credentialData = "\(user):\(password1)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString()
        let headers = [
            "Authorization": "Basic \(base64Credentials)",
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]
        
        Alamofire.request(ookami_issues_url, method: .get, parameters: nil,encoding: URLEncoding(destination: .queryString), headers: headers) .responseJSON { response in
            
            
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



