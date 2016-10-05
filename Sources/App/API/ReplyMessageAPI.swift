import Foundation

class ReplyMessageAPI: LineAPI{
    
    let endpoint = "https://api.line.me/v2/bot/message/reply"
    
    let method = "POST"
    
    var body: [String : Any]?{
        
        let payload: [String: Any] = [
            "replyToken": replyToken,
            "messages": [
                ["type": "text", "text": message]
            ]
        ]
        
        return payload
    }
    
    let replyToken: String
    let message: String
    
    init(replyToken: String, message: String){
        self.replyToken = replyToken
        self.message = message
    }
}
