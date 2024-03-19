//
//  ApiRouter.swift
//  CovidDemoProject
//
//  Created by Amit Gupta on 17/03/24.
//

import Foundation
import Alamofire

// APIRouter Enum to create request

enum APIRouter: URLRequestConvertible {
    case covidList
    // MARK: - HTTPMethod
    
    private var method: HTTPMethod {
        switch self {
        case .covidList:
            return .get
        }
    }
    
    // MARK: - Parameters
    
    private var parameters: Parameters? {
        switch self {
        case .covidList:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url =  Environment.rootURL
        var urlRequest = URLRequest(url:  URL(string: url)!)

        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}

