//
//  ViewController.swift
//  TestMoya
//
//  Created by Coke on 2019/4/12.
//  Copyright © 2019 Coke. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //最基本的Moya调用
//       let provider = MoyaProvider<XjkAPI>()
//        provider.request(.testApi) { (result) in
//            switch result{
//                case let .success(response):
//                    print(response)
//                case let .failure(error):
//                    print(error)
//            }
//        }
//
//        provider.manager.session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
//            dataTasks.forEach{$0.cancel()}
//            uploadTasks.forEach{$0.cancel()}
//            downloadTasks.forEach{$0.cancel()}
//        }
        //最终的调用
        let cancellable = NetWorkRequest(.testApi) {  result in
            print(result)
        }
        
        
        //取消请求
       //cancellable.cancel()
    }

    
}

