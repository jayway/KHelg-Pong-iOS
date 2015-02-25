## Description

Some boilerplate code for the Pong Game competence event.

## Prerequisites

* Download and install node.js from [http://www.nodejs.org](http://www.nodejs.org)
* Run the following commands in the terminal:
  * ```git clone https://github.com/jayway/KHelgGameServer.git```
  * ```npm install```

*Installation of node.js via homebrew doesn't work since it doesn't come with npm for some reason*

Further details and specification about the server is available at: [https://github.com/jayway/KHelgGameServer](https://github.com/jayway/KHelgGameServer.git).

## Project information

Use the ```.xcworkspace``` file. There are two scenes in the storyboard and three classes provided. You are free to change, remove and do what you want with everything. 

* ```ConnectionViewController.swift``` is the initial view controller. Contains basic UI for connecting and communicating with other players. 
* ```GameViewController.swift``` is where the game will be displayed. 
* ```SocketController.swift``` is responsible for the connection to the server via SocketIO. 

In ```ConnectionViewController.swift``` there is a constant NSURL with the address to the server:

```swift
let url = NSURL(scheme: "ws", host: "localhost:3000", path: "/")!
```
You can change this to point to [https://jaywaypongserver.herokuapp.com/](https://jaywaypongserver.herokuapp.com/) where there is a published version of the server.

### SIOSocket
The project uses [SIOSocket](https://github.com/MegaBits/SIOSocket) for communication with the server. 

#### To connect:
```swift 
SIOSocket.socketWithHost(urlString) { (socket) -> Void in
    self.socket = socket
}
```

#### Properties:
```swift
socket.onConnect = {
	println("Connected")
}

socket.onDisconnect = {
	println("Disconnected")
}
```

#### Listening for events:
```swift
socket.on("event to listen to") { (object: [AnyObject]!) in
	println("\(object.description)")
}
```
**Note**: put the properties and listening for events inside the connection closure.

#### Sending events:
```swift
self.socket?.emit("message type", args: [AnyObject]!)
```	

SIOSocket will handle serialization and deserialization to and from JSON for you.

**WARNING**: All SIOSocket callbacks happen on a background thread. If you are going to update UI from a callback, make sure to dispatch the call back to the main thread first!