import Vapor
import Node
import JSON
import Foundation
import HTTP

let drop = Droplet()

LineAPIConfig.configure(with: drop.config)

drop.post("/callback"){ req in
    
    guard let object = req.data["events"]?.array?.first?.object else{
        return Response(status: .ok, body: "this message is not supported")
    }
    
    guard let message = object["message"]?.object?["text"]?.string, let replyToken = object["replyToken"]?.string else{
        return Response(status: .ok, body: "this message is not supported")
    }
    
    ReplayMessageAPI(replyToken: replyToken, message: message).send()
    
    return Response(status: .ok, body: "reply")
    
}

drop.run()
