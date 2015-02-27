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
    var socketController: SocketController!
    
    // MARK: view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.socketController = SocketController(delegate: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "play pong" {
            let gameViewController = segue.destinationViewController as GameViewController
            // implement
        }
    }
    
    @IBAction func connect(sender: UIButton) {
        self.socketController.connectTo(url)
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
