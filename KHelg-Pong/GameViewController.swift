//
//  GameViewController.swift
//  KHelg-Pong
//
//  Created by Petar Mataic on 25/02/15.
//  Copyright (c) 2015 Jayway. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, SocketControllerGamingDelegate {
    
    var socket : SocketController? {
        didSet {
            self.socket?.gameDelegate = self
        }
    }
    
    var first = true
    
    var steeringTimer : NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pong"
    }
    
    
    var accumulatedPos : CGFloat = 0
    
    @IBOutlet weak var touchPad: UIView!
    @IBOutlet weak var gameBoard: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var myPaddle: UIView!
    @IBOutlet weak var opponentPaddle: UIView!
    
    
    @IBOutlet weak var ballView: UIView!
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.steeringTimer?.invalidate()
        self.first = true
    }
    
    func didStep(socketController: SocketController, step: Step){
        if  first{
            first = false
            self.spinner.stopAnimating()
            println("Player1: \(step.players.player1.name) VS player2: \(step.players.player2.name)")
            self.steeringTimer = NSTimer.scheduledTimerWithTimeInterval(1/10, target: self, selector: Selector("runTimer"), userInfo: nil, repeats: true)
        }
        var xRatio = step.bounds.width / self.gameBoard.bounds.size.width
        var yRatio = step.bounds.height / self.gameBoard.bounds.size.height
        
        self.ballView.frame.origin.x = step.ball.position.x * xRatio
        self.ballView.frame.origin.y = step.ball.position.y * yRatio
        
        self.opponentPaddle.frame.origin.x = step.opponentPaddle.origin.x * xRatio
        self.myPaddle.frame.origin.x = step.playerPaddle.origin.x * xRatio
        
        self.gameBoard.setNeedsDisplay()
    }
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        var pos = sender.translationInView(touchPad)
        self.accumulatedPos += pos.x
        sender.setTranslation(CGPointZero, inView: touchPad)
    }
    
    func runTimer() {
        let theMove = ["paddle": ["x": self.accumulatedPos*2, "y": 0]]
        println("theMove: \(theMove)")
        self.socket?.socket?.emit("move", args: [theMove])
        self.accumulatedPos = 0
    }
    
    
}
