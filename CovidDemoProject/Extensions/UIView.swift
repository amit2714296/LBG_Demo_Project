//
//  UIView.swift
//  CovidDemoProject
//
//  Created by Amit Gupta on 17/03/24.
//

import UIKit

extension UIView{
    
    static var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.1).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 8
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
