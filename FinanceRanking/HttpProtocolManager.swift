//
//  HttpProtocolManager.swift
//  FinanceRanking
//
//  Created by UramMyeongbu on 2017. 9. 24..
//  Copyright © 2017년 UramMyeongbu. All rights reserved.
//

import Foundation
import ObjectMapper

class HttpProtocolManager {
    static let shared = HttpProtocolManager()
    
    func requestFinanceAppList(completion: @escaping (Bool) -> Void){
        let url = URL(string: "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json")
        
        var request = URLRequest.init(url: url!)
        request.httpMethod = "POST" // POST ,GET, PUT What you want
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) {data,response,error in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                Mapper<Feed>().map(JSON: json["feed"] as! [String: Any])
                
                completion(true)
                
            } catch let error as NSError {
                print(error.localizedDescription)
                
                completion(false)
            }
            
        }
        dataTask.resume()
    }
}