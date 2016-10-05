import Foundation

protocol LineAPI{
    var client: HTTPClient { get }
    var endpoint: String { get }
    var method: String { get }
    var body: [String: Any]? { get}
}

extension LineAPI{
    var client: HTTPClient{
        return CurlHTTPClient()
    }
}

extension LineAPI{
    func send(){
        
        var request = URLRequest(url: URL(string: endpoint)!)
        
        request.httpMethod = method
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(LineAPIConfig.ACCESS_TOKEN)", forHTTPHeaderField: "Authorization")
        
        if let body = body{
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        }
        
        client.sendRequest(request: request)
    }
}
