//
//  ViewController.swift
//  GitHub_issue_pre
//
//  Created by 吉田れい on 2019/08/29.
//  Copyright © 2019 吉田れい. All rights reserved.
//

import UIKit
import Alamofire
import Foundation



class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let issues_run = Issue_number()
        issues_run.issue()
        //issues_run.issues_List()
        
        
        //play.issue()
        //play.Encoder()
        // Do any additional setup after loading the view.
    }
}

//配列型のパースを実施するためのプロトコルを定義
public protocol Decodable {
    init(from decoder: Decoder) throws
}

//basicm認証 成功! 2019/08/31
//アクセス方法に自身で設定したアクセストークンを設定したことで
//ookami_organizationへのアクセス権限を得ることができた

let user = "rei-yoshi"
let password = "rei07041998"
var value_issue:Any = 0
var query_number : Int = 0
var issue_number = 4909
let httpHeaderRequests = ["Authorization" : "b6ff772c33cf01489563c06a3d051d340e881c77","Accept" : "application/vnd.github.v3.text+json"]

//クエリを指定
let ookami_issues_url:String = "https://api.github.com/repos/ookamiinc/ios/issues/\(issue_number)"


let ookami_issues_List_url : String = "https://api.github.com/repos/ookamiinc/ios/issues"

let ookami_issues_comments_url = "https://api.github.com/repos/ookamiinc/ios/issues/4862/comments"
let password1 = "b2614f7260406de3045822714e2d06e674c52777"


let credentialData = "\(user):\(password1)".data(using: String.Encoding.utf8)!
let base64Credentials = credentialData.base64EncodedString()
let headers = [
    "Authorization": "Basic \(base64Credentials)",
    "Accept": "application/json",
    "Content-Type": "application/json",
]
var parameters : Parameters? {
    return [
        "Accept": "application/vnd.github.v3+json",
    ]
}



//issueの最新のnumberを取得する
class Issue_number {
    
    
    
    /*
     //issuesのそれぞれのtitleを抽出して一覧表示しようと考えたが
     //({title="",body="",...},{title="",body="",..},{title="",body="",...}のような形式の
     //JSONデータのパースを実行できていないため一旦保留
     
     
    
    //issues一覧のtitleを取得するメソッド
    //ルートが配列の時のパースを実装する
    func issues_List(){
        Alamofire.request(ookami_issues_List_url, method: .get, parameters: parameters,encoding: URLEncoding(destination: .queryString), headers: headers) .responseJSON { response in
            
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
            guard let data=response.data else {
                return
            }
            let decorder = JSONDecoder()
            
            
            //guard文で書き変え
            //issuesのtitleを取得する用
            
            struct Issues_List : Codable {
                var title : String
                var body: String
                var number : Int
                var comments_url : String
            }

            do{
                let issue_List: Issues_List = try decorder.decode(Issues_List.self,from: data)
                //issues_JSON型で
                //print(task)
                
                print(issue_List.title)
                print(issue_List.body)
                
                
                query_number = issue_List.number
            }
            catch{
                print(error)
            }
        }
    }
    
    */
    
    
    //特定のクエリを指定した時のパースを実装したもの
    func issue(){
        Alamofire.request(ookami_issues_url, method: .get, parameters: parameters,encoding: URLEncoding(destination: .queryString), headers: headers) .responseJSON { response in
            
            
            
             switch response.result {
             case .success(let value):
             print(value)
             value_issue = value
             //your success code
             case .failure(_):
             print("error")
             }
             
            
            
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










