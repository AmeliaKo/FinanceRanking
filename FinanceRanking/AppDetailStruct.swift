//
//  AppDetailStruct.swift
//  FinanceRanking
//
//  Created by UramMyeongbu on 2017. 9. 24..
//  Copyright © 2017년 UramMyeongbu. All rights reserved.
//

import Foundation
import ObjectMapper

class AppDetailStruct {
    static let shared = AppDetailStruct()
    
    var detail : Detail!
}

struct Detail  : Mappable {
    var appDescription : String!
    var screenshotUrls : [String]!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        appDescription <- map["description"]
        screenshotUrls <- map["screenshotUrls"]
    }
}
