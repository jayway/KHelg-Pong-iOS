//
//  PongView.swift
//  KHelg-Pong
//
//  Created by Gustaf Nilklint on 2015-02-28.
//  Copyright (c) 2015 Jayway. All rights reserved.
//

import UIKit

@IBDesignable
class PongView: UIView {

    
    var step : Step? {
        
        didSet {
            self.setNeedsDisplay()
        }
        
    }
    
    override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext();
        let border = CGRectInset(self.bounds, 10.0, 10.0)
        CGContextSetLineWidth(ctx, 2.0)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        CGContextStrokeRect(ctx, border)
        
        if (self.step != nil) {
            
        }
        
        
    }
    
}
