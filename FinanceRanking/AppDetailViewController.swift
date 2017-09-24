//
//  AppDetailViewController.swift
//  FinanceRanking
//
//  Created by UramMyeongbu on 2017. 9. 24..
//  Copyright © 2017년 UramMyeongbu. All rights reserved.
//

import UIKit

class AppDetailViewController: UIViewController {
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var appId : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        HttpProtocolManager.shared.requestAppDetail { () in
            DispatchQueue.main.async {
                for i in 0..<AppDetailStruct.shared.detail.screenshotUrls.count {
                    
                    let imageView = UIImageView()
                    let url = URL.init(string: AppDetailStruct.shared.detail.screenshotUrls[i])
                    imageView.sd_setImage(with: url)
                    imageView.contentMode = .scaleAspectFit
                    let xPosition = (self.view.frame.width) * CGFloat(i)
                    imageView.frame = CGRect(x: xPosition, y: self.scrollView.frame.origin.y, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
                    
                    self.scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(i + 1)
                    self.scrollView.addSubview(imageView)
                }
                
                 self.descriptionTextView.text = AppDetailStruct.shared.detail.appDescription
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
