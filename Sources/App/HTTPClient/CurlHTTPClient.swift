import Foundation

class CurlHTTPClient: HTTPClient{
    
    func sendRequest(request: URLRequest){
        
        #if os(Linux)
        let process = Task()
        #else
        let process = Process()
        #endif
        
        process.launchPath = "/usr/bin/curl"
        process.arguments = extractArguments(request: request)
        
        let pipe = Pipe()
        process.standardOutput = pipe
        process.launch()
        
        let outputData = pipe.fileHandleForReading.readDataToEndOfFile()
        let outputStr = NSString(data: outputData, encoding: String.Encoding.utf8.rawValue)
        print(outputStr)
    }
    
    private func extractArguments(request: URLRequest) -> [String]{
        var arguments: [String] = []
        
        if let url = request.url?.absoluteString{
            arguments.append(url)
        }
        
        if let method = request.httpMethod{
            arguments.append("-X")
            arguments.append("\(method)")
        }
        
        if let body = request.httpBody, let bodyStr = NSString(data: body, encoding: String.Encoding.utf8.rawValue){
            arguments.append("-d")
            arguments.append("\(bodyStr)")
        }
        
        if let header = request.allHTTPHeaderFields{
            for (key, value) in header{
                arguments.append("-H")
                arguments.append("\(key): \(value)")
            }
        }
        
        return arguments
    }
}
