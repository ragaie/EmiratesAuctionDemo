//
//  ListView.swift
//  EmiratesAuctionDemo
//
//  Created by Ragaie Alfy on 7/5/18.
//  Copyright © 2018 Ragaie Alfy. All rights reserved.
//

import UIKit

class ListView: UIViewController {

    var myController : ListController!
    
    
    @IBOutlet weak var carsTableView: UITableView!
    
    @IBOutlet weak var viewTitle: UILabel!
    
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var sortButton: UIButton!
   
    @IBOutlet weak var gridViewButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    var refreshControl : UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        myController = ListController()
        myController.myView = self
        
        carsTableView.delegate = myController
        carsTableView.dataSource = myController
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(myController, action: #selector(ListController.refreshCarsData(_:)), for: .valueChanged)

        carsTableView.addSubview(refreshControl)
        
        
        if currentLanguage() == "ar"{
        
            backButton.setImage(UIImage.init(named: "backR"), for: .normal)
        }
        else{
            backButton.setImage(UIImage.init(named: "back"), for: .normal)

        
        }
        
        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        myController.invalidTimer()
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


    @IBAction func backButton(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func currentLanguage ()-> String{
        
        let prefferedLanguage = Locale.preferredLanguages[0] as String
        print (prefferedLanguage) //en-US
        
        let arr = prefferedLanguage.components(separatedBy: "-")
        let deviceLanguage = arr.first
        
        
        
        return deviceLanguage!
        
        
        
    }
    
}
