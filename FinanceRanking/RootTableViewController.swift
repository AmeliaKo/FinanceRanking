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
    
   let AppDetailIdentifier = "appDetailIdentifier"
    
   override func viewDidLoad() {
        super.viewDidLoad()

        HttpProtocolManager.shared.requestFinanceAppList { (isComplete) in
            if(isComplete) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeedSturcts.sharedInstance.entryListCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        let url = URL.init(string: FeedSturcts.sharedInstance.feed.entryList[indexPath.row].imageList[0].label)
        cell.iconImageView.sd_setShowActivityIndicatorView(true)
        cell.iconImageView.sd_setIndicatorStyle(.gray)
        cell.iconImageView.sd_setImage(with: url, placeholderImage: nil, completed: { (loadedImage, error, cacheType, url) in
            cell.iconImageView.sd_removeActivityIndicator()
            if error != nil {
                print(error!.localizedDescription)
            } else {
                cell.iconImageView.image = loadedImage
            }
        })

        cell.nameLabel.text = FeedSturcts.sharedInstance.feed.entryList[indexPath.row].name.label

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppDetailIdentifier,
            let destination = segue.destination as? AppDetailViewController,
            let index = tableView.indexPathForSelectedRow?.row
        {
            FeedSturcts.sharedInstance.selectedId =  FeedSturcts.sharedInstance.feed.entryList[index].id.attributes.id
        }
    }
}

class TableViewCell : UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
}

