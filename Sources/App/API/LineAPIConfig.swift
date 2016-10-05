import Settings

class LineAPIConfig{

    fileprivate(set) static var ACCESS_TOKEN = ""
    
    class func configure(with config: Config){
        
        // Channel Access Token
        guard let accessToken = config["line_config", "access_token"]?.string else{
            fatalError("error, put line_config.json into Config/secrets and write access_token")
        }
        
        ACCESS_TOKEN = accessToken
    }
}
