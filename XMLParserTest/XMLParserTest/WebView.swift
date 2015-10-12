//
//  WebView.swift
//  XMLParserTest
//
//  Created by Jimmy Jose on 29/08/14.
//  Copyright (c) 2014 Varshyl Mobile Pvt. Ltd. All rights reserved.
//

import UIKit

class WebView : UIViewController,UIWebViewDelegate{
    
    @IBOutlet var webView:UIWebView? = UIWebView()
    var urlString:NSString!
    var activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.color = UIColor.blueColor()
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        webView?.delegate = self
        webView?.loadRequest(NSURLRequest(URL: NSURL(string: urlString as String)!))
        
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView){
        
        activityIndicator.stopAnimating()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?){
        
        activityIndicator.stopAnimating()
        
    }
    
    
}