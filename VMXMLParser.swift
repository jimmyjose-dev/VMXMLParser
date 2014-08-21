//
//  VMXMLParser.swift
//  XMLParserTest
//
//  Created by Jimmy Jose on 22/08/14.
//  Copyright (c) 2014 Varshyl Mobile Pvt. Ltd. All rights reserved.
//

import Foundation

class VMXMLParser: NSObject,NSXMLParserDelegate{
    
    
    private var activeElement = ""
    private var arrayFinalXML = NSMutableArray()
    private var dictFinalXML  = NSMutableDictionary()
    private var completionHandler:((tags:NSArray?, error:String?)->Void)?
    
    override init() {
        
        super.init()
    }
    
    func parseXMLForUrl(#url:NSString,completionHandler:((tags:NSArray?, error:String?)->Void)? = nil){
        
        self.completionHandler = completionHandler
        
        beginParsingXMLForUrl(url)
        
    }
    
    private func beginParsingXMLForUrl(urlString:NSString){
        
        let url:NSURL = NSURL(string:urlString)
        
        let request:NSURLRequest = NSURLRequest(URL:url)
        
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request,queue:queue,completionHandler:{response,data,error in
            
            if(error){
                if(self.completionHandler != nil){
                    self.completionHandler?(tags:nil,error:error.localizedDescription)
                }
                println(error.userInfo)
                println(error.localizedDescription)
                
            }else{
                
                var parser = NSXMLParser(data: data)
                parser.delegate = self
                
                var success:Bool = parser.parse()
                
                if success {
                    
                    if(self.dictFinalXML.count>0){
                        self.arrayFinalXML.addObject(self.dictFinalXML)
                    }
                    
                    if(self.arrayFinalXML != nil){
                        if(self.completionHandler != nil){
                            self.completionHandler?(tags:self.arrayFinalXML,error:nil)
                        }
                    }
                    
                } else {
                    
                    if(self.completionHandler != nil){
                        self.completionHandler?(tags:nil,error:"parse failure!")
                    }
                }
                
            }})
    }
    
    
    internal func parser(parser: NSXMLParser!,didStartElement elementName: String!, namespaceURI: String!, qualifiedName : String!, attributes attributeDict: NSDictionary!) {
        
        activeElement = elementName;
    }
    
    
    internal func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        
        activeElement = ""
    }
    
    
    internal func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        
        
        var str = string as NSString
        
        str = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if(dictFinalXML.objectForKey(activeElement)){
            
            arrayFinalXML.addObject(dictFinalXML)
            dictFinalXML = NSMutableDictionary()
            
        }
        
        if(str.length > 0){
            
            dictFinalXML.setValue(str, forKey: activeElement)
        }
        
    }
    
    
    internal func parser(parser: NSXMLParser!, parseErrorOccurred parseError: NSError!) {
        if(self.completionHandler != nil){
            self.completionHandler?(tags:nil,error:parseError.localizedDescription)
        }
    }
    
}