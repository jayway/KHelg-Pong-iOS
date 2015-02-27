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
        let urlString = url.absoluteString!
        println("Connecting to: \(urlString)")
        
        SIOSocket.socketWithHost(urlString) { (theSocket) -> Void in
            println("creating the socket")
            self.socket = theSocket
            println("socket assigned")
            
            self.socket?.onConnect = {
                dispatch_async(dispatch_get_main_queue()){
                    self.delegate?.connected(self)
                    return
                }
            }
            
            self.socket?.on("players", callback: { (result) -> Void in
                let root = result.first as [String : AnyObject]
                println("players updated")
            })
            
            self.socket?.on("message", callback: { (message) -> Void in
                
                let root = message.first as [String : AnyObject]
                if let message = root["message"] as? String {
                    let player = root["player"] as String
                    dispatch_async(dispatch_get_main_queue()){
                        let visualString = "\(player): \(message)"
                        self.delegate?.receivedMessage(self, message: visualString)
                        return
                    }
                }
                
            })
            
            self.socket?.on("step", callback: { (message) -> Void in
                
            })
            
            self.socket?.onError = { (errorInfo) in
                println("Something bad happend: \(errorInfo)")
            }
        }
    }
    
    func disconnect() {
        
    }
    
    // Implement!
    
}