//
//  Utils.swift
//  FinanceRanking
//
//  Created by UramMyeongbu on 2017. 9. 24..
//  Copyright © 2017년 UramMyeongbu. All rights reserved.
//

import Foundation
import ObjectMapper

struct Feed  : Mappable {
    var author : Author!
    
    init?(map: Map) {
        author <- map["author"]
        print(author)
    }
    
    mutating func mapping(map: Map) {
        
    }
}

struct Author : Mappable {
    var name : Label!
    var uri : Label!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         name <- map["name"]
         uri <- map["uri"]
    }
}

struct Label : Mappable {
    var label : String!
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        label <- map["label"]
        
        print(label)
    }
}
