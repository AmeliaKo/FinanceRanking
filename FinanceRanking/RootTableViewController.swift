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
    
   override func viewDidLoad() {
        super.viewDidLoad()

        HttpProtocolManager.shared.requestFinanceAppList { (isComplete) in
            if(isComplete) {
                self.tableView.reloadData()
            }
        }
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
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

//        let url = URL.init(string: self.feed.entryList[indexPath.row].imageList[0].label)
//        cell.imageView?.sd_setShowActivityIndicatorView(true)
//        cell.imageView?.sd_setIndicatorStyle(.gray)
//        cell.imageView?.sd_setImage(with: url, placeholderImage: nil, completed: { (loadedImage, error, cacheType, url) in
//            cell.imageView?.sd_removeActivityIndicator()
//            if error != nil {
//                print(error!.localizedDescription)
//            } else {
//                cell.imageView?.image = loadedImage
//            }
//        })
//
//        cell.nameLabel.text = self.feed.entryList[indexPath.row].name.label

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

class TableViewCell : UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
}

