//
//  APIRequest.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

typealias APIRequestCompletionType = (_ result: Result<Data, APIError>) -> Void
    
protocol APIRequestDelegate {
    func sendRequest(completion: @escaping APIRequestCompletionType)
    var http: Http! { get set }
}

class APIRequest: NSObject {
    
    private let timeoutInterval: TimeInterval = 20
    
    internal var http: Http!
    private var session: URLSession!
    private var completion: APIRequestCompletionType!
    
    private override init() {
        super.init()
    }
    
    init(session: URLSession = .shared) {
        super.init()
        self.session = session
    }
    
    private func failAction(with error: APIError) {
        DispatchQueue.main.async { [weak self] in
            self?.completion(.failure(error))
            self?.session.finishTasksAndInvalidate()
        }
    }
    
    private func successAction(with data: Data) {
        DispatchQueue.main.async { [weak self] in
            self?.completion(.success(data))
            self?.session.finishTasksAndInvalidate()
        }
    }
    
    
    private func printHttpResponse(httpResponse: HTTPURLResponse) {
        Logger.log("""
            ----------
            URL: \(httpResponse.url?.absoluteString ?? "-")
            Status: \(httpResponse.statusCode)
            """, level: .info)
        
    }
    
    private func printHttpRequest(with responseData: Data? = nil) {
        do {
            if let body = self.http.body {
                let requestJSON = try JSONSerialization.jsonObject(with: body, options: []) as? NSDictionary
                Logger.log("Req Object: \(requestJSON!)", level: .info)
            }
            if let respData = responseData {
                let requestJSON = try JSONSerialization.jsonObject(with: respData, options: []) as? NSDictionary
                Logger.log("Resp Object: \(requestJSON!)", level: .info)
            }
        } catch let err {
            Logger.log("JSON Serialization Error: \(err)", level: .error)
        }
    }
    
    
}

extension APIRequest: APIRequestDelegate {
    
    func sendRequest(completion: @escaping APIRequestCompletionType) {
        self.completion = completion
        guard let request = getRequest() else {
            self.failAction(with: .invalidRequestURLString)
            return
        }
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else {return}
            
            if let httpResponse = response as? HTTPURLResponse {
                self.printHttpResponse(httpResponse: httpResponse)
            }
            
            if let err = error {
                self.printHttpRequest()
                self.failAction(with: .failedRequest(description: err.localizedDescription))
                return
            }
            
            if let respData = data {
                self.printHttpRequest(with: respData)
                self.successAction(with: respData)
            }
        }
        task.resume()
    }
    
    private func getRequest() -> URLRequest? {
        
        guard let url = URL(string: "\(Configuration.baseURL)\(self.http.path)") else { return nil }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: TimeInterval(timeoutInterval))
        request.httpMethod = self.http.method.rawValue
        request.allHTTPHeaderFields = ["ContentType": "application/json", "Accept": "application/json"]
        request.httpBody = http.method == .get ? nil : http.body
        return request
        
    }
    
}
