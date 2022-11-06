//
//  UILabel+Extension.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 8.09.2022.
//

import Foundation
import UIKit

extension UILabel {
    
    func styleLabel(title:String,textAlignment:NSTextAlignment,color:UIColor,fontSize:UIFont ){
        self.text = title
        self.textAlignment = textAlignment
        self.textColor = color
        self.font = fontSize
        self.numberOfLines = 0
    }
    
    
}
