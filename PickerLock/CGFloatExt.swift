//
//  CGFloatExt.swift
//  PickerLock
//
//  Created by saurabh deopura on 1/4/17.
//  Copyright © 2017 Deopura. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat{
    
    public static func random() -> CGFloat{
        
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    public static func random(min : CGFloat, max : CGFloat) -> CGFloat{
        
        return CGFloat.random() * (max - min) + min
    }
    
}
