//
//  ListController.swift
//  EmiratesAuctionDemo
//
//  Created by Ragaie Alfy on 7/5/18.
//  Copyright © 2018 Ragaie Alfy. All rights reserved.
//

import UIKit

class ListController: NSObject ,UITableViewDelegate,UITableViewDataSource{
    var myModel : ListModel!
    private var myContext = 0
    
    var myView : ListView!

    override init() {
        
        
        super.init()
            myModel = ListModel()
            myModel.addObserver(self,forKeyPath: "flage",options: .new,context: &myContext)
        
        myModel.getAllData()
            
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if context == &myContext {
            myView.carsTableView.reloadData()
            
            myView.refreshControl.endRefreshing()

        }
        
    }
    
  func refreshCarsData(_ sender: Any) {
        // Fetch Weather Data
        myModel.getAllData()
    }
    
    func invalidTimer(){
    
    
       if myModel.timer != nil {
        
        myModel.timer.invalidate()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myModel.allCarsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellCarID", for: indexPath) as! CarTableViewCell
        
        
        cell.setData(carData: myModel.allCarsList[indexPath.row])
        return cell
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
}
