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
        let inset = CGFloat(10.0)
        let border = CGRectInset(self.bounds, inset, inset)
        let outerPath = UIBezierPath(roundedRect: border, cornerRadius: 5.0)
        UIColor.blackColor().set()
        outerPath.lineWidth = 3.0
        outerPath.stroke()
        
        if let s = self.step {
            let xRatio = border.size.width / s.bounds.width
            let yRatio = border.size.height / s.bounds.height
            
            // My paddle
            let myPaddleRect = CGRectMake(s.playerPaddle.origin.x * xRatio + inset,
                s.playerPaddle.origin.y * yRatio + inset,
                s.playerPaddle.width * xRatio,
                s.playerPaddle.height * yRatio)
            let myPaddle = UIBezierPath(rect: myPaddleRect)
            UIColor.greenColor().set()
            myPaddle.fill()
            
            // Opponent Paddle
            let opponentPaddleRect = CGRectMake(s.opponentPaddle.origin.x * xRatio + inset,
                s.opponentPaddle.origin.y * yRatio + inset,
                s.opponentPaddle.width * xRatio + inset,
                s.opponentPaddle.height * yRatio)
            let opPaddle = UIBezierPath(rect: opponentPaddleRect)
            UIColor.redColor().set()
            opPaddle.fill()
            
            // Ball
            let ballCenter = CGPointMake(s.ball.position.x * xRatio + inset,
                s.ball.position.y * yRatio + inset)
            let ball = UIBezierPath(arcCenter: ballCenter, radius: CGFloat(s.ball.radius * xRatio), startAngle: 0.0, endAngle: CGFloat(2 * M_PI) , clockwise: true)
            UIColor.blackColor().set()
            ball.fill()
            
        }
        
        
    }
    
}
