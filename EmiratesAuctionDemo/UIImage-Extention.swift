//
//  UIImage-Extention.swift
//  AJ-Total
//
//  Created by Ragaie Alfy on 8/5/17.
//  Copyright © 2017 Ragaie alfy. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageWithURL(urlString : String){
    
        var indecator : UIActivityIndicatorView! = UIActivityIndicatorView.init(frame: CGRect.init(x: self.frame.midX  - 20
            , y: self.frame.midY  - 20 , width: 20, height: 20))
    
        
        indecator.center = self.center
        indecator.color = UIColor.black
        indecator.startAnimating()
        self.addSubview(indecator)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL.init(string: urlString)!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            if data != nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                    indecator.stopAnimating()

                }
            }
            else{
                indecator.stopAnimating()

            }
            

    
        }

}


}
