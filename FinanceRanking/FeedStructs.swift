//
//  FeedStructs.swift
//  FinanceRanking
//
//  Created by UramMyeongbu on 2017. 9. 24..
//  Copyright © 2017년 UramMyeongbu. All rights reserved.
//

import Foundation
import ObjectMapper

class FeedSturcts {
    static let sharedInstance = FeedSturcts()
    
    var feed:Feed!
    var selectedId : String!
    
    func entryListCount() -> Int {
        if(self.feed != nil && self.feed.entryList != nil)
        {
            return feed.entryList.count
        } else {
            return 0
        }
    }
}

struct Feed  : Mappable {
    var author : Author!
    var entryList : [AppEntry]!
    
    init?(map: Map) {
        author <- map["author"]
        entryList <- map["entry"]
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

struct AppEntry : Mappable {
    var name : Label!
    var imageList : [Label]!
    var id : Id!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["im:name"]
        imageList <- map["im:image"]
        id <- map["id"]
    }
}

struct Id : Mappable {
    var attributes : Attributes!
    
    init?(map: Map) {
        attributes <- map["attributes"]
    }
    
    mutating func mapping(map: Map) {
        
    }
}

struct Attributes : Mappable {
    var id : String!
    var bundleId : String!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["im:id"]
        bundleId <- map["im:bundleId"]
    }
}

struct Label : Mappable {
    var label : String!
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        label <- map["label"]
    }
}
