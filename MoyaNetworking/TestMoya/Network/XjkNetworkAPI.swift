//
//  XjkAPI.swift
//  TestMoya
//
//  Created by Coke on 2019/4/12.
//  Copyright © 2019 Coke. All rights reserved.
//

import UIKit
import Moya
import Alamofire

enum XjkAPI {
    case testApi
    case testApiAllKey(para:String,para1:String)
    case testApiDict(param:[String:Any])
}


extension XjkAPI:TargetType{
    
    //服务器地址
    var baseURL: URL{
        return URL.init(string: "https://api.douban.com/v2/movie/top250")!
    }
    //具体某个方法的路径
    var path: String{
        
        switch self {
        case .testApi:
            return ""
        case .testApiAllKey( _, _):
            return "bbbb"
        case .testApiDict(_):
            return "xxx"
        
        }
    }
    //请求的方法 get或者post之类的
    var method: HTTPMethod{
        
        switch self {
        case .testApi:
            return HTTPMethod.get
        default:
            return HTTPMethod.get
        }
     
    }
    
    //编码转义
    var sampleData: Data{
        return Data.init()
    }
   //一个请求任务事件
    var task: Task{
        switch self {
        case .testApi:
            return .requestPlain
        default:
            return .requestData(Data.init())
        }
    }
    //请求的get post给服务器的头参数
    var headers: [String : String]?{
        return nil
    }
    
    //请求的get post给服务器的参数
    var parameters: [String: Any]? {
        switch self {
        case .testApi:
            return nil
        default:
            return nil
            
        }
    }
    //验证状态码
    private var validationType: ValidationType?{
        switch self {
        case .testApi:
            return .successCodes
        default:
            return .none
        }
    }
    
    //编码的格式
    var parameterEncoding: ParameterEncoding {
       
        return URLEncoding.default
    }
    
    //加载请求是否可以点击屏幕
    var touch:Bool{
        switch self {
        case .testApi:
            return true
        default:
            return false
        }
        
    }
    //是否显示转圈提示
    var show: Bool {
        
        switch self {
        case .testApi:
            return true
        default:
            return false
        }
        
    }
   

}
