
//
//  ListView.swift
//  EmiratesAuctionDemo
//
//  Created by Ragaie Alfy on 7/5/18.
//  Copyright © 2018 Ragaie Alfy. All rights reserved.
//


import UIKit
import SystemConfiguration


protocol getRemoteData {
    func parseData(result : AnyObject,flagSender :String);
    
}

//

////patrick.emyrey@purplebureau.com
extension getRemoteData {

    

    
    func getUrlData(parameter : AnyObject, url : String,way :String,flagSender : String) -> Void{
        
        
        
        
    if isConnectedToNetwork() == true {
            
  
        
        
        // show indecator
       UIApplication.shared.isNetworkActivityIndicatorVisible = true
    

            ShowIndecator(type: "start")
     
        
    if (way == "get") {
        
            
            let url = NSURL(string:url)!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField:"Content-Type")
            
            
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
                if error != nil{
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    if let parseJSON = json {
                        
                        self.sucessToGetData(data: parseJSON as AnyObject,flagSender: flagSender)
                        
                        
                    }
                } catch let error as NSError {
                    
                    self.failGetData()
                }
            }
            task.resume()
        
        

        
    }
        
        
      else if (way == "post") {
        
   
        
        
        
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameter, options: []) {
            
            
            let url = NSURL(string:url)!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField:"Content-Type")
            
            
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
                if error != nil{
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    if let parseJSON = json {
                        
                        
                        DispatchQueue.main.async {
                            self.sucessToGetData(data: parseJSON as AnyObject,flagSender: flagSender)
                        
                        
                        }


                    }
                } catch let error as NSError {
                    DispatchQueue.main.async {
                        self.failGetData()
                        
                        
                    }
                }
            }          
            task.resume()
        }
   
        
        
        
      
        
        }
        
 
        
  }
        
    else{
        
        UIAlertView.init(title: "Alert", message: "Check you internet Connection", delegate: nil, cancelButtonTitle: "غلق").show()
        
        }
    
    
}
    
    
    
    
    func sucessToGetData(data :AnyObject,flagSender:String) -> Void{
        
        
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        ShowIndecator(type: "stop")

        parseData(result: data,flagSender: flagSender)
        
        
        
        
    }
    
    func ShowIndecator(type : String) -> Void {
        
        var  appdelegate : AppDelegate!
        
        
        if appdelegate == nil {
            appdelegate =  UIApplication.shared.delegate as! AppDelegate
        }
        if SingleClass.indecator == nil {
            
       
                SingleClass.indecator = UIActivityIndicatorView.init(frame:CGRect.init(x: (appdelegate.window!.frame.width / 2) - 30 , y: (appdelegate.window!.frame.height / 2 ) - 30   , width: 60, height: 60))
            
            
            SingleClass.indecator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.init(rawValue: 16)!
            
            
            SingleClass.indecator.color = UIColor.black
            
            

            
            
            
        }
        
        if type == "start"{
            
            UIApplication.shared.keyWindow?.addSubview(SingleClass.indecator)

            
            SingleClass.indecator.startAnimating()

          
            
            
        }else if type == "stop"{
            
            SingleClass.indecator.stopAnimating()
            
            
            
             SingleClass.indecator = nil
        }
        
        
    }
    

    
    
    func failGetData() -> Void {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false

        
        ShowIndecator(type: "stop")
        
        UIAlertView.init(title: "Alert", message: "Fail to connect server Please try again", delegate: nil, cancelButtonTitle: "OK").show()
        
    
    
        print("fail to get data  ")
    }
    
    
    
    
     func isConnectedToNetwork() -> Bool {
            
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
                return false
            }
            
            /* Only Working for WIFI
             let isReachable = flags == .reachable
             let needsConnection = flags == .connectionRequired
             
             return isReachable && !needsConnection
             */
            
            // Working for Cellular and WIFI
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            let ret = (isReachable && !needsConnection)
            
            return ret
            
        }
    

}


