//
//  ListModel.swift
//  EmiratesAuctionDemo
//
//  Created by Ragaie Alfy on 7/5/18.
//  Copyright © 2018 Ragaie Alfy. All rights reserved.
//

import UIKit

class ListModel: NSObject,getRemoteData {
   
    dynamic var flage : String!
    var allCarsList : [Car]! = []
    var ticks : String! = ""
    
    var refreshInterval : Double! = 0
    var timer : Timer!
    override init() {
        super.init()
       

    }
    
    
    
    deinit {
        
        
    }
   
    func getAllData(){
    
        
        let tempDict :NSMutableDictionary! = NSMutableDictionary()
       
                
        tempDict.setValue(ticks, forKey: "Ticks")
        
        
        getUrlData(parameter: tempDict, url: UrlData.carListURl, way: "post", flagSender: "listValue")

    
    }
    
    
    func parseData(result: AnyObject, flagSender: String) {
        
   // print(result)
        
        
        if  result.object(forKey: "Cars") != nil {
        
            let carsData = result.object(forKey: "Cars") as! [[String : AnyObject]]
        
            allCarsList = []
            for item in carsData {
                var tempCar : Car = Car()
            
                tempCar.setObject(objectDic: item)
                
                allCarsList.append(tempCar)
        
            }
            flage = "data finished"

        }
        
        
        flage = "data finished"
        ticks = result.object(forKey: "Ticks") as! String
        
        refreshInterval = result.object(forKey: "RefreshInterval") as! Double
        
        
        timer = Timer.scheduledTimer(timeInterval: refreshInterval, target:self, selector: #selector(ListModel.getAllData), userInfo: nil, repeats: false)
    }
    
    

}
