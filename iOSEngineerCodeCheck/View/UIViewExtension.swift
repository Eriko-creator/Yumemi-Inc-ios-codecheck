//
//  UIViewExtension.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/04.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    @IBInspectable
    var cornerRadius: CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
}
