//
//  VMXMLParser.swift
//  XMLParserTest
//
//  Created by Jimmy Jose on 22/08/14.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

// Todo: Add documentation
class VMXMLParser: NSObject,NSXMLParserDelegate{
    
    private let kParserError = "Parser Error"
    private var activeElement = ""
    private var previousElement = "-1"
    private var previousElementValue = ""
    private var arrayFinalXML = NSMutableArray()
    private var dictFinalXML  = NSMutableDictionary()
    private var completionHandler:((tags:NSArray?, error:String?)->Void)?
    
    var lameMode = true
    
    var reoccuringTag:NSString = ""
    
    /**
    Initializes a new parser with url of NSURL type.
    
    :param: url The url of xml file to be parsed
    :param: completionHandler The completion handler
    
    :returns: Void.
    */
    
    override init() {
        
        super.init()
        
    }
    
    func parseXMLFromURL(url:NSURL,takeChildOfTag:NSString,completionHandler:((tags:NSArray?, error:String?)->Void)? = nil){
        
        self.reoccuringTag = takeChildOfTag
        VMXMLParser().initWithURL(url, completionHandler: completionHandler)
        
    }
    
    func parseXMLFromURLString(urlString:NSString,takeChildOfTag:NSString,completionHandler:((tags:NSArray?, error:String?)->Void)? = nil){
        self.reoccuringTag = takeChildOfTag
        
        initWithURLString(urlString, completionHandler: completionHandler)
    }
    
    
    func parseXMLFromData(data:NSData,takeChildOfTag:NSString,completionHandler:((tags:NSArray?, error:String?)->Void)? = nil){
        self.reoccuringTag = takeChildOfTag
        initWithContentsOfData(data, completionHandler:completionHandler)
        
    }
    
    
    class func initParserWithURL(url:NSURL,completionHandler:((tags:NSArray?, error:String?)->Void)? = nil){
        
        VMXMLParser().initWithURL(url, completionHandler: completionHandler)
        
    }
    
    class func initParserWithURLString(urlString:NSString,completionHandler:((tags:NSArray?, error:String?)->Void)? = nil){
        
        VMXMLParser().initWithURLString(urlString, completionHandler: completionHandler)
    }
    
    
    class func initParserWithData(data:NSData,completionHandler:((tags:NSArray?, error:String?)->Void)? = nil){
        
        VMXMLParser().initWithContentsOfData(data, completionHandler:completionHandler)
        
    }
    
    
    private func initWithURL(url:NSURL,completionHandler:((tags:NSArray?, error:String?)->Void)? = nil) -> AnyObject {
        
        parseXMLForUrl(url :url, completionHandler: completionHandler)
        
        return self
        
    }
    
    
    
    private func initWithURLString(urlString :NSString,completionHandler:((tags:NSArray?, error:String?)->Void)? = nil) -> AnyObject {
        
        let url = NSURL.URLWithString(urlString)
        parseXMLForUrl(url :url, completionHandler: completionHandler)
        
        return self
    }
    
    private func initWithContentsOfData(data:NSData,completionHandler:((tags:NSArray?, error:String?)->Void)? = nil) -> AnyObject {
        
        initParserWith(data: data)
        
        return self
        
    }
    
    private func parseXMLForUrl(#url:NSURL,completionHandler:((tags:NSArray?, error:String?)->Void)? = nil){
        
        self.completionHandler = completionHandler
        
        beginParsingXMLForUrl(url)
        
    }
    
    private func beginParsingXMLForUrl(url:NSURL){
        
        let request:NSURLRequest = NSURLRequest(URL:url)
        
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request,queue:queue,completionHandler:{response,data,error in
            
            if(error != nil){
                if(self.completionHandler != nil){
                    self.completionHandler?(tags:nil,error:error.localizedDescription)
                }
                
            }else{
                
                self.initParserWith(data: data)
                
            }})
    }
    
    
    private func initParserWith(#data:NSData){
        
        var parser = NSXMLParser(data: data)
        parser.delegate = self
        
        var success:Bool = parser.parse()
        
        if success {
            
            if(self.arrayFinalXML.count > 0){
                if(self.completionHandler != nil){
                    self.completionHandler?(tags:self.arrayFinalXML,error:nil)
                }
            }
            
        } else {
            
            if(self.completionHandler != nil){
                self.completionHandler?(tags:nil,error:kParserError)
            }
        }
        
    }
    
    
    internal func parser(parser: NSXMLParser!,didStartElement elementName: String!, namespaceURI: String!, qualifiedName : String!, attributes attributeDict: NSDictionary!) {
        
        activeElement = elementName;
        
        if(reoccuringTag.isEqualToString(elementName)){
            
            dictFinalXML = NSMutableDictionary()
        }
    }
    
    
    internal func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        
        if(reoccuringTag.length == 0){
            if((dictFinalXML.objectForKey(activeElement)) != nil){
                
                arrayFinalXML.addObject(dictFinalXML)
                dictFinalXML = NSMutableDictionary()
                
            }else{
                
                dictFinalXML.setValue(previousElementValue, forKey: activeElement)
            }
        }else{
            //println(elementName)
            if(reoccuringTag.isEqualToString(elementName)){
                
                arrayFinalXML.addObject(dictFinalXML)
                dictFinalXML = NSMutableDictionary()
                
            }else{
                
                dictFinalXML.setValue(previousElementValue, forKey: activeElement)
                
            }
            
        }
        
        previousElement = "-1"
        previousElementValue = ""
        
    }
    
    
    internal func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        
        var str = string as NSString
        
        str = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if((previousElement as NSString).isEqualToString("-1")){
            
            previousElement = activeElement
            previousElementValue = str
            
        }else{
            
            if((previousElement as NSString).isEqualToString(activeElement)){
                
                previousElementValue = previousElementValue + str
                
            }else{
                
                previousElement = activeElement
                previousElementValue = str
            }
        }
        
    }
    
    
    internal func parser(parser: NSXMLParser!, parseErrorOccurred parseError: NSError!) {
        if(self.completionHandler != nil){
            self.completionHandler?(tags:nil,error:parseError.localizedDescription)
        }
    }
    
}