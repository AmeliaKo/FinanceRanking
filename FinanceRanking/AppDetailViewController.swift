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
    
    var appId : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        HttpProtocolManager.shared.requestAppDetail { () in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
