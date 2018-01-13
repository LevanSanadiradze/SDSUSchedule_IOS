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
    
    var weburl:String = "http://schedule.sdsu.edu.ge/scheduleappios/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url: NSURL = NSURL(string: weburl)!
        let requestURL: NSURLRequest = NSURLRequest(url: url as URL)
        ww.loadRequest(requestURL as URLRequest)
        
//        UIWebView.loadRequest(webView)(NSURLRequest(url: NSURL(string: "http://facebook.com/")! as URL) as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
//        if request.url?.query?.range(")
        return true;
    }

}

