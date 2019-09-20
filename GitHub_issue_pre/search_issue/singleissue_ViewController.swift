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
import MarkdownView


public class singleissue_ViewController: UIViewController {
    
    //markdownviewの宣言
    var mdView = MarkdownView()
    
    //viewControllerから値をもらう時の引き取り変数
    var issues_number: Int?
    var body : String?
    
    var issues_title : String!
    var issues_body : String!
    //var issues_number : String
    
    
    @IBOutlet weak var issue_title: UILabel!
    // @IBOutlet weak var issue_Number :UILabel!
    let issue_body = UIScrollView()
    @IBOutlet weak var body_text : UITextView!
    
    
    
    
    
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        issue()
        }
    
    //Titleラベルにissueのタイトルを表示
    var issueTitle: String? {
        didSet{
            DispatchQueue.main.async {
                self.issue_title.text = self.issueTitle
            }
        }
    }
    
    //issueの中身を表示
    var issueBody : String?{
        didSet{
            //issue_bodyラベルの更新
            DispatchQueue.main.async{
                self.mdView.load(markdown : "\(String(describing: self.issueBody))")
                self.mdView.onRendered = {height in
                    self.issue_body.contentSize.width = self.view.bounds.width
                    self.issue_body.frame = self.view.frame
                    self.view.addSubview(self.issue_body)
                    
                }
            }
        }
    }
    
    //特定のクエリを指定した時のパースを実装したもの
    func issue() {
        
        //basic認証 成功! 2019/08/31
        //アクセス方法に自身で設定したアクセストークンを設定したことで
        //ookami_organizationへのアクセス権限を得ることができた
        //ViewControllerクラスから入力値をもらう(issuenum.issue_number)->クエリの指定
        let user = "rei-yoshi"
        //let password = "rei07041998"
        let password1 :String = "5be4ad53ae9617e4443bd9421af21525d0d39bd2"
        let ookami_issues_url : String = "https://api.github.com/repos/ookamiinc/ios/issues/\(String(describing: issues_number!))"
        let credentialData = "\(user):\(password1)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString()
        let headers = [
            "Authorization": "Basic \(base64Credentials)",
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]
        
        
        Alamofire.request(ookami_issues_url, method: .get, parameters: nil,encoding: URLEncoding(destination: .queryString), headers: headers) .responseJSON { response in
            
            guard let data=response.data else {
                return
            }
            let decorder = JSONDecoder()
            
            //guard文で書き変え
            //パースすることに成功
            //queryを指定した時に実施する用
            //numberの取得
            struct issues_JSON : Codable {
                var title : String
                var body: String
            }
            
            do{
                let task : issues_JSON = try
                    decorder.decode(issues_JSON.self,from : data)
                
                
                //self.issue_title.text = "\(task.title)"
                self.issueTitle = task.title
                self.issueBody = task.body
                
                //markdown用
                //self.mdView.load(markdown : "\(task.title)")
                //self.issue_title.text = "\(mdView.markdown)"
                
                
                //確認用
                // print(task.title)
                // print(task.body)
                
                //self.issue_title.text = "\(String(describing: self.mdView))"
                //self.body = task.body
                
                /*
                 func markdown(){
                 //markdownview
                 self.body = task.body
                 self.mdView.load(markdown:(self.body))
                 DispatchQueue.main.async {
                 self.issue_title.text = "\(String(describing: self.body)))"
                 }
                 }*/
            }
            catch let error{
                print(error)
            }
        }
    }
}

//配列型のパースを実施するためのプロトコルを定義
public protocol Decodable {
    init(from decoder: Decoder) throws
}



