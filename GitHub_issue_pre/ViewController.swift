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
        
        
        //play.issue()
        //play.Encoder()
        // Do any additional setup after loading the view.
    }
    
}



//GitHub上で作成したトークンを用いて認証を行った
//自分のアカウントへのアクセスURL:取得できているのでOK
//let urlString :String = "https://api.github.com/repos/ookamiinc/ios/issues/ access_token=0ce6965a6ad1bdf7f547f51d6e66a85529f7a711"

//お手本のurl：このurlからはデータを取得できているのでOK
//let urlString: String="https://api.github.com/search/issues?q=windows+label:bug+language:python+state:open&sort=created&order=asc"



//ookamiincへのアクセスが通らない
//usernameとpasswordが必要！
//let urlString:String = "https://api.github.com/repos/ookamiinc/ios/issues/"
//let parameter : String = "q"

/*
 func getissue(){
 Alamofire.request(urlString, method:.get)
 .responseJSON{ Response in
 print(Response.result.value)
 }
 }
 
 func view_issue(){
 getissue()
 }
 */

/*
 class Issues{
 
 func issue(){
 Alamofire.request( urlString,method:.get).responseJSON {
 response in
 switch response.result {
 case .success(let Value):
 print(Value)
 value_issue = Value
 case .failure(let Error):
 print(Error)
 }
 }
 }
 struct Issues_JSON : Codable {
 var body:String
 }
 
 let decoder : JSONDecoder = JSONDecoder()
 func Encoder(){
 do {
 let json : Issues_JSON = try decoder.decode(Issues_JSON.self,from:value_issue as! Data)
 print(json)
 }
 catch{
 print("error",error.localizedDescription)
 }
 }
 
 
 }
 */

//basic認証をtryするために作ったコード
/*
 func issue(){
 Alamofire.request( ookami_url, method : .post )
 .authenticate(user: user, password: password)
 .response { response in
 print(response)
 
 }
 }
 */

/*
 let credentialData = ("\(user):\(password)").data(using : String.Encoding.utf8)!
 let base64Credentials = credentialData.base64EncodedString(options : [])
 var request = URLRequest(url: NSURL(string : ookami_url)! as URL )
 var headers: HTTPHeaders = [:]
 
 func issue(){
 let credentialData = ("\(user):\(password)").data(using: String.Encoding.utf8)
 let base64Credentials = credentialData!.base64EncodedString(options : [])
 
 if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
 headers[authorizationHeader.key] = authorizationHeader.value
 
 Alamofire.request(ookami_url, headers: headers)
 .validate().responseJSON { response in
 switch response.result{
 
 case .success(let Value):
 print(Value)
 
 case .failure:
 print("error")
 }
 }
 }
 }
 */

//basicm認証 成功! 2019/08/31
//アクセス方法に自身で設定したアクセストークンを設定したことで
//ookami_organizationへのアクセス権限を得ることができた

let user = "rei-yoshi"
let password = "rei07041998"
var value_issue:Any = 0
var query_number : Int = 0

let ookami_issues_url:String = "https://api.github.com/repos/ookamiinc/ios/issues/4907"
let ookami_issues_comments_url = "https://api.github.com/repos/ookamiinc/ios/issues/4862/comments"
let password1 = "b6ff772c33cf01489563c06a3d051d340e881c77"


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






//issueの最新のnumbeρを取得する
class Issue_number {
    
    var parameters :Parameters = [String : Any] ()
    //put slash before \ (base64Credentials)
    
    //number取得メソッド
    func issue(){
        Alamofire.request(ookami_issues_url, method: .get, parameters: parameters,encoding: URLEncoding(destination: .queryString), headers: headers) .responseJSON { response in
            
            
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
                print(task.comments_url)
                query_number = task.number
                
            }
            catch{
                print(error)
            }
        }
    }
    
    
}










//2019/09/02
//JSON形式のパースの実施

















