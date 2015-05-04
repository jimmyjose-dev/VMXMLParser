//
//  DetailView.swift
//  XMLParserTest
//
//  Created by Jimmy Jose on 29/08/14.
//  Copyright (c) 2014 Varshyl Mobile Pvt. Ltd. All rights reserved.
//

import UIKit

class DetailView : UIViewController{
    
    @IBOutlet var textView:UITextView? = UITextView()
    
    var urlString:NSString!
    var text:NSString!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        textView?.text = text as String
    }
    
    @IBAction func showInBrowser() {
        self.performSegueWithIdentifier("Webview", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var webViewController = segue.destinationViewController as! WebView
        webViewController.title = "WebView"
        webViewController.urlString = urlString!
    }
}