//
//  ViewController.swift
//  SDSUSchedule_IOS
//
//  Created by Anano on 13.01.18.
//  Copyright © 2018 SDSU. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    
    @IBOutlet weak var ww: UIWebView!
    
    var weburl:String = "http://schedule.sdsu.edu.ge/index.php/ios/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ww.scrollView.bounces = false
        
        let url: NSURL = NSURL(string: weburl)!
        let requestURL: NSURLRequest = NSURLRequest(url: url as URL)

        ww.loadRequest(requestURL as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        return true;
    }
    

}

