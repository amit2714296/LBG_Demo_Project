//
//  APIClientProtocol.swift
//  CovidDemoProject
//
//  Created by Amit Gupta on 17/03/24.
//

import Foundation
import Alamofire



/// Enum for Network failures with error messages

enum APIError: String, Error{
    case requestError  = "Request failed"
    case networkError  = "Network failure"
    case responseError = "Response error"
    case parsingError  = "Failed to parse JSON"
}

/// Generic Rescult object with both .success and .failure
/// - parameter T: class or struct of Codable type on .success
/// - parameter U: error of any type on .failure

enum Result<T : Codable, U: Error> {
    case success(data: T)
    case failure(U?)
}

/// APIClient protocol with a method perform network request

protocol APIClientProtocol : AnyObject{
    
    var sessionManager: SessionManager { get set }
    
    func performRequest<T: Decodable>(route: APIRouter, completionHandler: @escaping (DataResponse<T>) -> ())
}


