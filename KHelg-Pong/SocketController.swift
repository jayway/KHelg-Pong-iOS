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

protocol SocketControllerGamingDelegate: class {
    func didStep(socketController: SocketController, step: Step)
}

class SocketController {
    
    weak var delegate: SocketControllerDelegate?
    weak var gameDelegate: SocketControllerGamingDelegate?
    var socket: SIOSocket?
    
    init(delegate: SocketControllerDelegate) {
        self.delegate = delegate
    }
    
    // Finish implementation
    func connectTo(url: NSURL, player: String) {
        let urlString = url.absoluteString!
        println("Connecting to: \(urlString)")
        
        SIOSocket.socketWithHost(urlString) { (theSocket) -> Void in
            self.socket = theSocket
            self.socket?.onConnect = {
                self.socket?.emit("add player", args: [["playername" : player]])
                dispatch_async(dispatch_get_main_queue()){
                    self.delegate?.connected(self)
                    return
                }
            }
            
            self.socket?.on("players", callback: { (result) -> Void in
//                let root = result.first as [String : AnyObject]
//                println("players updated")
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
                if let root = message.first as? [String: AnyObject]{
                    var step = Step(json: root)
                    dispatch_async(dispatch_get_main_queue()){
                        self.gameDelegate?.didStep(self, step: step)
                        return
                    }
                }
            })
            
            self.socket?.onError = { (errorInfo) in
                println("Something bad happend: \(errorInfo)")
            }
        }
    }
    
    func disconnect() {
        
    }
    
    func beginPlaying() {
        self.socket?.emit("ready")
    }
    
    // Implement!
    
}