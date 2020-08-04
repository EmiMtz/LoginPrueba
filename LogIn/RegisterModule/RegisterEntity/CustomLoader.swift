//
//  CustomLoader.swift
//  LogIn
//
//  Created by sferea on 04/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialActivityIndicator
 
class CustomLoader: MDCActivityIndicator {
    
    let lblCounter = UILabel()
    
    func configLoader(){
        self.sizeToFit()
        self.radius = 30.0;
        self.strokeWidth = 4
        self.cycleColors = [UIColor.mainPink()]
        self.backgroundColor =  UIColor(white: 1, alpha: 0.7)
        lblCounter.textColor = UIColor.systemPink
        self.addSubview(lblCounter)
        lblCounter.anchor(centerY: self.centerYAnchor, centerX: self.centerXAnchor, constantY: 60)
    }

}

extension UIView {
    func anchor(centerY: NSLayoutYAxisAnchor?,centerX : NSLayoutXAxisAnchor?, constantY: CGFloat? = 0.0, constantX: CGFloat? = 0.0){
        translatesAutoresizingMaskIntoConstraints  = false
        if let centerX = centerX, let constantx = constantX{
            centerXAnchor.constraint(equalTo: centerX, constant: constantx).isActive = true
        }
        if let centerY = centerY, let constanty = constantY{
            //            centerYAnchor.constraint(equalTo: centerY).isActive = true
            centerYAnchor.constraint(equalTo: centerY, constant: constanty).isActive = true
        }
    }
}

