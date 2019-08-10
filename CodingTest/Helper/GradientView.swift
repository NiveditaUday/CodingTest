//
//  GradientView.swift
//  CodingTest
//
//  Created by user on 08/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = [UIColor(red: 250/255, green: 90/255, blue: 140/255, alpha:1).cgColor, UIColor(red: 247/255, green: 107/255, blue: 110/255, alpha:1).cgColor]
    }
}
