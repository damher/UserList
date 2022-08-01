//
//  HTTPNetworkRequest.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

typealias HTTPParameters = [String: Any?]?
typealias HTTPHeaders = [String: Any]?

struct HTTPNetworkRequest {
    
    // MARK: Configure HTTP request
    static func configureHTTPRequest(from url: String, parameters: HTTPParameters, headers: HTTPHeaders, body: Data?, method: HTTPMethod) throws -> URLRequest {
        
        guard let url = URL(string: url) else { fatalError("Error while unwrapping url") }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        try configureParametersAndHeaders(parameters: parameters, headers: headers, request: &request)
        
        return request
    }
    
    // MARK: Configure parameters and headers
    static func configureParametersAndHeaders(parameters: HTTPParameters?,
                                              headers: HTTPHeaders?,
                                              request: inout URLRequest) throws {
        do {
            if let headers = headers {
                try setHeaders(for: &request, with: headers)
            }
            
            if let parameters = parameters {
                try setParameters(for: &request, with: parameters)
            }
        } catch {
            throw HTTPNetworkError.encodingFailed
        }
    }
    
    // MARK: Set headers
    static func setHeaders(for urlRequest: inout URLRequest, with headers: HTTPHeaders) throws {
            guard let headers = headers else { return }
            for (key, value) in headers {
                urlRequest.setValue("\(value)", forHTTPHeaderField: key)
        }
    }
    
    // MARK: Set parameters
    static func setParameters(for urlRequest: inout URLRequest, with parameters: HTTPParameters) throws {
        guard let url = urlRequest.url else { throw HTTPNetworkError.missingURL }
        guard let params = parameters else { return }
        guard !params.isEmpty else { return }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        
        urlComponents.queryItems = [URLQueryItem]()
        
        for (key, value) in params {
            if let value = value {
                if let array = value as? Array<AnyObject> {
                    for item in array {
                        let queryItem = URLQueryItem(name: key, value: "\(item)")
                        urlComponents.queryItems?.append(queryItem)
                    }
                } else {
                    let queryItem = URLQueryItem(name: key, value: "\(value)")
                    urlComponents.queryItems?.append(queryItem)
                }
            }
        }
        
        if let additionalEncodedString = urlComponents.string?.replacingOccurrences(of: "+", with: "%2B") {
            urlRequest.url = URL(string: additionalEncodedString)
        }
    }
}
