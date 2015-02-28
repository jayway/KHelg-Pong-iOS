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
        CGContextSetLineWidth(ctx, 3.0)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        CGContextStrokeRect(ctx, border)
        
        if let s = self.step {
            let xRatio = border.size.width / s.bounds.width
            let yRatio = border.size.height / s.bounds.height
            
            // My paddle
            let myPaddleRect = CGRectMake(s.playerPaddle.origin.x * xRatio,
                s.playerPaddle.origin.y * yRatio,
                s.playerPaddle.width * xRatio,
                s.playerPaddle.height * yRatio)
            let myPaddle = UIBezierPath(rect: myPaddleRect)
            UIColor.greenColor().set()
            myPaddle.fill()
            
            // Opponent Paddle
            let opponentPaddleRect = CGRectMake(s.opponentPaddle.origin.x * xRatio,
                s.opponentPaddle.origin.y * yRatio,
                s.opponentPaddle.width * xRatio,
                s.opponentPaddle.height * yRatio)
            let opPaddle = UIBezierPath(rect: opponentPaddleRect)
            UIColor.redColor().set()
            opPaddle.fill()
            
            // Ball
            let ballCenter = CGPointMake(s.ball.position.x * xRatio, s.ball.position.y * yRatio)
            let ball = UIBezierPath(arcCenter: ballCenter, radius: CGFloat(s.ball.radius * xRatio), startAngle: 0.0, endAngle: CGFloat(2 * M_PI) , clockwise: true)
            UIColor.blackColor().set()
            ball.fill()
            
        }
        
        
    }
    
}
