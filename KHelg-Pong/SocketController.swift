//
//  SocketController.swift
//  KHelg-Pong
//
//  Created by Petar Mataic on 25/02/15.
//  Copyright (c) 2015 Jayway. All rights reserved.
//

import Foundation

protocol SocketControllerDelegate: class {
    func connected(socketController: SocketController)
    func disconnected(socketController: SocketController)
    func receivedMessage(socketController: SocketController, message: String)
}

class SocketController {
 
    weak var delegate: SocketControllerDelegate?
    var socket: SIOSocket?
    
    init(delegate: SocketControllerDelegate) {
        self.delegate = delegate
    }
    
    // Finish implementation
    func connectTo(url: NSURL) {
        
    }
    
    func disconnect() {
        
    }
    
    // Implement!
    
}