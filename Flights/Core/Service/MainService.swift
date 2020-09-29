//
//  MainService.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

protocol ServiceDelegate {
    func send<T: Codable, R: GenericRespLogic>(api: API, request: T?, completion: @escaping (_ result: Result<R, APIError>) -> Void)
    func send<R: GenericRespLogic>(api: API, completion: @escaping (_ result: Result<R, APIError>) -> Void)
}

class MainService: ServiceDelegate {
    
    static let shared = MainService(codableHelper: CodableHelper(), apiRequest: APIRequest())
    
    private var codableHelper: CodableHelperDelegate!
    private var apiRequest: APIRequestDelegate!
    
    init(codableHelper: CodableHelperDelegate, apiRequest: APIRequestDelegate) {
        self.codableHelper = codableHelper
        self.apiRequest = apiRequest
    }
    
    func send<T: Codable, R: GenericRespLogic>(api: API, request: T? = nil, completion: @escaping (_ result: Result<R, APIError>) -> Void) {
        var http = Http(path: api.endpoint.path, method: api.endpoint.method)
        if let reqObj = request, let body = codableHelper.encode(requestObj: reqObj) {
            http.body = body
        }
        apiRequest.http = http
        apiRequest.sendRequest { [weak self] (result) in
            switch result {
            case .success(let data):
                guard let respObj = self?.codableHelper.decode(type: R.self, data: data) else {
                    completion(.failure(.invalidResponseModel))
                    return
                }
                completion(.success(respObj))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func send<R: GenericRespLogic>(api: API, completion: @escaping (_ result: Result<R, APIError>) -> Void) {
        send(api: api, request: Optional<GenericResp>.none, completion: completion)
    }
}
