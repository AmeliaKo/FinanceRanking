//
//  RootTableViewController.swift
//  FinanceRanking
//
//  Created by UramMyeongbu on 2017. 9. 23..
//  Copyright © 2017년 UramMyeongbu. All rights reserved.
//

import UIKit
import ObjectMapper
import SDWebImage

enum JSONError: String, Error {
    case NoData = "ERROR: no data"
}

class RootTableViewController: UITableViewController {
  var feed : Feed!
    
   override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
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
                self.feed = Mapper<Feed>().map(JSON: json["feed"] as! [String: Any])
                print(self.feed!)
                
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        dataTask.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(self.feed != nil) {
            return self.feed.entryList.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        let url = URL.init(string: self.feed.entryList[indexPath.row].imageList[0].label)
        cell.imageView?.sd_setImage(with: url)
        cell.nameLabel.text = self.feed.entryList[indexPath.row].name.label

        return cell
    }
}

class TableViewCell : UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
}

