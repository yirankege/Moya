//
//  XjkNetworkMananger.swift
//  TestMoya
//
//  Created by Coke on 2019/4/12.
//  Copyright © 2019 Coke. All rights reserved.
//

import UIKit
import Moya


private var requestTimeOut:Double = 30


    
//设置请求参数
private let myEndpointClosure = { (target:XjkAPI) -> Endpoint in
    let url = target.baseURL.absoluteString + target.path
    var endpoint = Endpoint.init(
        url: url,
        sampleResponseClosure: { () -> EndpointSampleResponse in
       .networkResponse(200, target.sampleData)},
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers)
    switch target {
    case .testApi:
       
        return endpoint
    default:
        return endpoint
    }
}
    
//设置打印一些参数
private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    
    do {
        var request = try endpoint.urlRequest()
        
        //设置请求时长
        request.timeoutInterval = requestTimeOut
        // 打印请求参数
        if let requestData = request.httpBody {
            print("\(request.url!)"+"\n"+"\(request.httpMethod ?? "")"+"发送参数"+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        }else{
            print("\(request.url!)"+"\(String(describing: request.httpMethod))")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

//里面可以直接修改plugin回调里面的东西，用于添加自定义插件逻辑
private let networkPlugin = NetworkActivityPlugin.init { (changeType, target) in
 //   print("network changeType: \(changeType)")
    
    let api = target as! XjkAPI
    

    switch changeType{
    case .began:
        
        
        if  api.show == true{
            //在这里面可以通过之前在API里面设定的参数去控制是否菊花控件
        }
        
        if  api.touch == true{
            //在这里面可以通过之前在API里面设定的参数去控制是否能操作
        }

        
        print("network is starting")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    case .ended:
        print("network is end")
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}

//公共的生成Provider的方法
let Provider = MoyaProvider<XjkAPI>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)


typealias successCallback = ((String)->(Void))

//写一个最底层的回调，主要判断一些最基本的API，写共通代码
func NetWorkRequest(_ target:XjkAPI,completion:@escaping successCallback) -> Cancellable{
    // 判断是否有网络没有可以直接返回
   
    
    let cancellable = Provider.request(target) { (result) in
        
        switch result{
        
            case let .success(response):
            do{
               
                let jsonData = try JSONSerialization.jsonObject(with: response.data, options: .mutableContainers)
                
                    //如果是正常服务器接口会有状态码，把内容转成dictionary 然后把下面判断放出来就OK
//                if jsonData["statusCode"] == "200"{
                    completion(String(data: response.data, encoding: .utf8)!)
//                }else{
//                    print("statusCode不为200，服务器异常")
//                }
              
            }catch{
                
            }
            
            case let .failure(error):
            guard let error = error as? CustomStringConvertible else{
                print("网络连接失败")
                break
            }
        }
    }
    
    
  
    return cancellable
}
