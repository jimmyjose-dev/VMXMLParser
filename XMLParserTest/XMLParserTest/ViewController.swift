//
//  ViewController.swift
//  XMLParserTest
//
//  Created by Jimmy Jose on 21/08/14.
//  Copyright (c) 2014 Varshyl Mobile Pvt. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tableview:UITableView! = UITableView()
    
    var activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
    
    var tagsArray = NSArray()
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.color = UIColor.blueColor()
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        let url:String="http://images.apple.com/main/rss/hotnews/hotnews.rss"
        
        /*
        VMXMLParser.initParserWithURLString(url, completionHandler: {
        (tags, error) -> Void in
        if(error != nil){
        println(error)
        }else{
        dispatch_async(dispatch_get_main_queue()){
        self.tagsArray = tags!
        
        self.tableview.reloadData()
        self.activityIndicator.stopAnimating()
        }
        
        }
        })*/
        
        let tagName = "item"
        
        VMXMLParser().parseXMLFromURLString(url, takeChildOfTag: tagName) { (tags, error) -> Void in
            
            if(error != nil){
                print(error!)
            }else{
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tagsArray = tags!
                    
                    self.tableview.reloadData()
                    self.activityIndicator.stopAnimating()
                }
                
            }
            
            
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
        
        return tagsArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        let idxForValue:Int = indexPath.row
        
        let dictTable:NSDictionary = tagsArray[idxForValue] as! NSDictionary
        
        let title = dictTable["title"] as? String
        let subtitle = dictTable["pubDate"] as? String
        
        
        cell.textLabel!.text = title ?? ""
        cell.detailTextLabel!.text = subtitle ?? ""
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel!.font = UIFont(name: "Helvetica Neue Light", size: 15.0)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        selectedIndex = indexPath.row
        
        self.performSegueWithIdentifier("Detail", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let detailView = segue.destinationViewController as! DetailView
        
        detailView.title = "Detail"
        
        let dictTable:NSDictionary = tagsArray[selectedIndex] as! NSDictionary
        
        let description = dictTable["description"] as! NSString?
        let link = dictTable["link"] as! NSString?
        
        detailView.text = description!
        detailView.urlString = link!
        
        
    }
}