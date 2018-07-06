//
//  Car.swift
//  EmiratesAuctionDemo
//
//  Created by Ragaie Alfy on 7/5/18.
//  Copyright © 2018 Ragaie Alfy. All rights reserved.
//

import Foundation
import UIKit
struct Car {
    
    var currencyAr : String!
    var currencyEn : String!
    var currentPrice : Int!
   // endDate = 577256;
    
    var endDateAr : String!
    var endDateEn : String!
    var endDate : Double!

    var lot : Int!
    var bids : Int!

    
    
   var image : String!
    
  //make name of car
    
    var makeAr  : String!
    var makeEn : String!
    var makeID  : String!
    var modelAr  : String!
    var modelEn  : String!
    var modelID  : Int!
  

    func title()-> String{
        
        
        var title :String! = ""
        
        if currentLanguage() == "ar"{
            title.append(makeAr ?? "")
            title.append( " ")
            
            title.append(modelAr ?? "")
            title.append( " ")
            
            title.append(String(modelID) )
            return title
        }
        
        
        
        title.append(makeEn ?? "")
        title.append( " ")

        title.append(modelEn ?? "")
        title.append( " ")

        title.append(String(modelID) )
        return title
    }
    
    func getPrice()-> String{
    
        var price  = String(currentPrice)
        price.insert(",", at: price.index(price.endIndex, offsetBy: -3)) // prints hel!lo

    return price
    }
    func getCurrency() -> String {
        
        if currentLanguage() == "ar"{
            return currencyAr
        }
        return currencyEn

    }
    
    func setTimeLift(label : UILabel)  {
  
        let endD = Date(timeIntervalSince1970: endDate)
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: endD)
        let hour = comp.hour
        let minute = comp.minute
        if hour! == 0 && minute! < 5 {
            label.textColor = UIColor.red
        }
        else{
            label.textColor = UIColor.black
        }
        let format = DateFormatter()//yyyy-MM-dd
        format.dateFormat = "HH:mm:ss"
        label.text  = format.string(from: endD)
        
        
        
        
        
        
    }
    
    func imageUrl() -> String {
        
        
        var urlString = image.replacingOccurrences(of: "[w]", with: "400")
        
        urlString = urlString.replacingOccurrences(of: "[h]", with: "300")
                return urlString
        
    }


mutating func setObject(objectDic : [String : AnyObject]){

    
    
    if objectDic["AuctionInfo"] != nil {
        
        var auctionInfo = objectDic["AuctionInfo"] as! [String : AnyObject]
        lot = auctionInfo["lot"] as! Int
        bids = auctionInfo["bids"] as! Int

        currencyAr = auctionInfo["currencyAr"] as! String
        currencyEn = auctionInfo["currencyEn"] as! String
        currentPrice = auctionInfo["currentPrice"] as! Int
        // endDate = 577256;
        endDateAr = auctionInfo["endDateAr"] as! String
        endDateEn = auctionInfo["endDateEn"] as! String
        endDate = auctionInfo["endDate"] as! Double
        
        
        
    }

    
   
    image = objectDic["image"] as! String
    makeAr = objectDic["makeAr"] as! String
    makeEn = objectDic["makeEn"] as! String
    
    modelEn = objectDic["modelEn"] as! String
    modelID = objectDic["modelID"] as! Int
    
    
    
    
    
}

    func currentLanguage ()-> String{
    
        let prefferedLanguage = Locale.preferredLanguages[0] as String
        print (prefferedLanguage) //en-US
        
        let arr = prefferedLanguage.components(separatedBy: "-")
        let deviceLanguage = arr.first
      
        
        
        return deviceLanguage!
    
    
    
    }
    
    

}
