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
    
    //무료 앱 순위 리스트 50개 서버에서 가져오는 부분
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
                //data 받아서 Feed 구조체에 맵핑 하는 부분
                FeedSturcts.sharedInstance.feed = Mapper<Feed>().map(JSON: json["feed"] as! [String: Any])
                
                completion(true)
                
            } catch let error as NSError {
                print(error.localizedDescription)
                
                completion(false)
            }
            
        }
        dataTask.resume()
    }
    
    // 테이블 뷰에서 셀 선택시 앱 디테일 정보 서버에서 받아 오는 부분
    func requestAppDetail(completion: @escaping () -> Void){
        let url = URL(string: "https://itunes.apple.com/lookup?id=\(FeedSturcts.sharedInstance.selectedId!)&country=kr")
        
        var request = URLRequest.init(url: url!)
        request.httpMethod = "POST" // POST ,GET, PUT What you want
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) {data,response,error in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let object =  json["results"] as! [[String:Any]]
                // data 받아서 Detail 구조체에 맵핑 하는 부분
                AppDetailStruct.shared.detail = Mapper<Detail>().map(JSON:object[0])
                
                completion()
                
            } catch let error as NSError {
                print(error.localizedDescription)
             }
            
        }
        dataTask.resume()
    }
}
