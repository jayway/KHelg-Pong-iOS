//
//  ConnectionViewController.swift
//  KHelg-Pong
//
//  Created by Petar Mataic on 25/02/15.
//  Copyright (c) 2015 Jayway. All rights reserved.
//

import UIKit

class ConnectionViewController: UIViewController, SocketControllerDelegate {
    
    @IBOutlet weak var playButton: UIBarButtonItem!
    @IBOutlet weak var playerNameField: UITextField!
    @IBOutlet weak var logTextView: UITextView!
 
    let url = NSURL(string: "ws://jaywaypongserver.herokuapp.com:80")!
//    let url = NSURL(string: "ws://10.0.112.186:3000")!
    var socketController: SocketController!
    
    // MARK: view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.socketController = SocketController(delegate: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "play pong" {
            let gameViewController = segue.destinationViewController as GameViewController
            self.socketController.beginPlaying()
            gameViewController.socket = self.socketController
        }
    }
    
    @IBAction func connect(sender: UIButton) {
        if let playerName = self.playerNameField.text {
            self.socketController.connectTo(url, player: playerName)
        }
    }
    
    @IBAction func disconnect(sender: UIButton) {
        self.socketController.disconnect()
    }
    
    // MARK: SocketControllerDelegate
    
    func connected(socketController: SocketController) {
        self.playButton.enabled = true
        // TODO: Implement
    }
    
    func disconnected(socketController: SocketController) {
        self.playButton.enabled = false
        // TODO: Implement
    }
    
    func receivedMessage(socketController: SocketController, message: String) {
        // TODO: Implement
        self.logTextView.text = self.logTextView.text + "\n\(message)"
    }
    
}
