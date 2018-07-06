//
//  CarTableViewCell.swift
//  EmiratesAuctionDemo
//
//  Created by Ragaie Alfy on 7/5/18.
//  Copyright © 2018 Ragaie Alfy. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var carImage: UIImageView!
    
    @IBOutlet weak var carName: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var currencyTypeLabel: UILabel!
    
    
    
    @IBOutlet weak var lotLabel: UILabel!
    
    @IBOutlet weak var lotValueLabel: UILabel!
    
    
    @IBOutlet weak var bidsLabel: UILabel!
    
    
    @IBOutlet weak var bidsValue: UILabel!
    
    @IBOutlet weak var timelaftText: UILabel!
    
    
    @IBOutlet weak var timelafttext: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backGroundView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setData (carData : Car){
    
        carName.text = carData.title()
        priceLabel.text = carData.getPrice()
        
        currencyTypeLabel.text = carData.getCurrency()

        lotValueLabel.text = String(carData.lot)
        bidsValue.text = String(carData.bids)
        
        //set text and color 
        carData.setTimeLift(label: timelafttext)
        carImage.setImageWithURL(urlString: carData.imageUrl())
    
    
    
    
    }

}
