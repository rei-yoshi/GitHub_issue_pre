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
//import MarkdownView


public class singleissue_ViewController: UIViewController {
    //viewControllerから値をもらう時の引き取り変数
    var issues_number: Int?
    var body:String?
    // var body_temp: String
    var issues_title : String?
    var issues_body : String?
    //var issues_number : String
    
    @IBOutlet weak var issue_title: UILabel!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        guard issues_number != nil else {
            issue_title.text = "issue_Numberが入力されていません!"
            return()
        }
        
        /*
        let mdView = MarkdownView()
        mdView.frame = view.bounds
        mdView.load(markdown:"\(String(describing: body))")
        issue_title.text! = "\(view.addSubview(mdView))"
 */
        
        //nilではなかった時の処理
        //強制アンラップしているため後ほど変更を加える
        //issue_title.text = "\(String(describing: issues_title))"
        
        issue()
        
        
        
    }
    
    //特定のクエリを指定した時のパースを実装したもの
    func issue() {
        
        //basicm認証 成功! 2019/08/31
        //アクセス方法に自身で設定したアクセストークンを設定したことで
        //ookami_organizationへのアクセス権限を得ることができた
        //ViewControllerクラスから入力値をもらう(issuenum.issue_number)->クエリの指定
        let user = "rei-yoshi"
        //let password = "rei07041998"
        let password1 :String = "3a96a5dfe7a00b30ea90d7b43ca9d1d87aac02ee"
        let ookami_issues_url : String = "https://api.github.com/repos/ookamiinc/ios/issues/\(String(describing: issues_number!))"
        let credentialData = "\(user):\(password1)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString()
        let headers = [
            "Authorization": "Basic \(base64Credentials)",
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]
        
        
        
       
        Alamofire.request(ookami_issues_url, method: .get, parameters: nil,encoding: URLEncoding(destination: .queryString), headers: headers) .responseJSON { response in
            
            //guard文で書き変え
            //パースすることに成功
            //queryを指定した時に実施する用
            //numberの取得
            struct issues_JSON : Codable {
                var title : String
                var body: String
            }
            
            guard let data=response.data else {
                return
            }
            let decorder = JSONDecoder()
            do{
                 let task : issues_JSON = try
                 decorder.decode(issues_JSON.self,from : data)
                
                
                print(task.title)
                print(task.body)
                //
                self.issue_title.text = "\(task.body)"
                self.body = task.body
                
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



