//
//  URLSession.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

extension URLSession {
    
    @discardableResult
    func execute<T: Decodable>(url: String,
                               parameters: HTTPParameters = nil,
                               headers: HTTPHeaders = nil,
                               body: Data? = nil,
                               method: HTTPMethod = .get,
                               code: String? = nil,
                               requestId: String? = nil,
                               _ completion: @escaping (Result<T>) -> Void) -> URLSessionDataTask? {
        do {
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: url, parameters: parameters, headers: headers, body: body, method: method)
            
            let task = dataTask(with: request) { (data, response, error) in
                
                if let response = response as? HTTPURLResponse, let responseData = data {
                    
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        do {
                            let result = try JSONDecoder().decode(T.self, from: responseData)
                            completion(Result.success(result))
                        }  catch DecodingError.dataCorrupted(let context) {
                            debugPrint(DecodingError.dataCorrupted(context))
                            completion(Result.failure(HTTPNetworkError.couldNotParse))
                        } catch DecodingError.keyNotFound(let key, let context) {
                            debugPrint(DecodingError.keyNotFound(key, context))
                            completion(Result.failure(HTTPNetworkError.couldNotParse))
                        } catch DecodingError.typeMismatch(let type, let context) {
                            debugPrint(DecodingError.typeMismatch(type, context))
                            completion(Result.failure(HTTPNetworkError.couldNotParse))
                        } catch DecodingError.valueNotFound(let value, let context) {
                            debugPrint(DecodingError.valueNotFound(value, context))
                            completion(Result.failure(HTTPNetworkError.couldNotParse))
                        } catch {
                            completion(Result.failure(HTTPNetworkError.noData))
                        }
                    case .failure:
                        completion(Result.failure(response.statusCode == 403 ? HTTPNetworkError.forbidden : HTTPNetworkError.serverSideError))
                    }
                } else if let error = error {
                    if let err = error as? URLError, (err.code == URLError.Code.notConnectedToInternet || err.code == URLError.Code.dataNotAllowed) {
                        completion(Result.failure(HTTPNetworkError.failed))
                    } else {
                        completion(Result.failure(error))
                    }
                }
            }
            task.resume()
            return task
        } catch {
            completion(Result.failure(HTTPNetworkError.badRequest))
            return nil
        }
    }
}
