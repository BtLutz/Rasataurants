//
//  UIView+Additions.swift
//  Rasataurants
//
//  Created by Brian Lutz on 11/30/18.
//  Copyright © 2018 Gecko. All rights reserved.
//

import UIKit

extension UIView {
    func smoothRoundCorners(to radius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        
        layer.mask = maskLayer
    }
}
