//
//  API.swift
//  Moya
//
//  Created by Coke on 2019/4/12.
//  Copyright © 2019 Coke. All rights reserved.
//

import Foundation
import Moya


enum XjkAPI {
    case testApi
    case testApiAllKey(para:String,para1:String)
    case testApiDict(param:[String:Any])
}


extension XjkAPI:TragetType{
    
}
