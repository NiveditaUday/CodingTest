//
//  BottomBorderTextField.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class BottomBorderTextField : UITextField {
    
    override func draw(_ rect: CGRect) {
        
        let startingPoint   = CGPoint(x: rect.minX, y: rect.maxY)
        let endingPoint     = CGPoint(x: rect.maxX, y: rect.maxY)
        
        let path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: endingPoint)
        path.lineWidth = 2.0
        tintColor.setStroke()
        path.stroke()
    }
}
