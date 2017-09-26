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
            //UI셋팅하는건 메인 큐에서만 해줘야한데서..
            DispatchQueue.main.async {
                 self.configureScreenshot()
                 self.descriptionTextView.text = AppDetailStruct.shared.detail.appDescription
                 self.navigationItem.title = AppDetailStruct.shared.detail.artistName
            }
        }
    }
    
    // 스크린샷 페이지 처럼 보여주는 부분
    func configureScreenshot() {
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
    }
}

extension AppDetailViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("\(#function)")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("\(#function)")
       
        let page = Int(round(Double(scrollView.contentOffset.x) / Double(scrollView.bounds.size.width)))
        print("page : \(page)")
    }
}
