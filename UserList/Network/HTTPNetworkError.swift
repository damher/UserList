//
//  HTTPNetworkError.swift
//  UserList
//
//  Created by Mher Davtyan on 30.07.22.
//

import Foundation

enum HTTPNetworkError: String, Error {
    case encodingFailed = "Error Found: Parameter Encoding failed."
    case missingURL = "Error Found: The URL is nil."
    case couldNotParse = "Error Found: Unable to parse the JSON response."
    case noData = "Error Found: The data from API is Nil."
    case unwrappingError = "Error Found: Unable to unwrape the data."
    case success = "Successful Network Request"
    case authenticationError = "Error Found: You must be Authenticated"
    case badRequest = "Error Found: Bad Request"
    case failed = "Error Found: Network Request failed"
    case serverSideError = "Error Found: Server error"
    case forbidden = "Access is denied"
}
