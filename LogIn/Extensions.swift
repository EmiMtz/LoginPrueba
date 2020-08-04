//
//  Extensions.swift
//  LogIn
//

//  Created by Emiliano Martinez on 02/04/20.
//  Copyright © 2020 EmiMtz. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto

extension UIColor {
    
    //Color principal de la app
    class func mainPink() -> UIColor {
        return UIColor(red:0.86, green:0.04, blue:0.36, alpha:1.0)
    }
    
}

extension String{
    func MD5() -> String{
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = self.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}

extension UIViewController{
    func showIndicator(onMain: Bool = false){
        //Prevents double loader
        if (self.view.subviews.last as? CustomLoader) == nil{
            let activityIndicator = CustomLoader()
            activityIndicator.configLoader()
            activityIndicator.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
    }
    
    func hideIndicator()
    {
        var vc = self
        if  let activityIndicator = vc.view.subviews.last as? CustomLoader{
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        } else {
            vc = UIApplication.shared.keyWindow!.rootViewController!
            if  let activityIndicator = vc.view.subviews.last as? CustomLoader{
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    func alertaError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    func alertaSuccess(title: String, message: String, completionOk:(() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true, completion: completionOk)
    }
}
