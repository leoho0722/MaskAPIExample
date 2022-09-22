//
//  NetworkConstants.swift
//  MaskAPIExample
//
//  Created by Leo Ho on 2022/9/21.
//

import Foundation

struct NetworkConstants {
    
    static let baseURL = "https://"
    
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
        case xml = "application/xml"
        case x_www_form_urlencoded = "application/x-www-form-urlencoded"
    }
    
    enum HTTPMethod: String {
        case options = "OPTIONS"
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
        case trace   = "TRACE"
        case connect = "CONNECT"
    }

    enum RequestError: Error {
        case unknownError
        case connectionError
        case invalidResponse
        case jsonDecodeFailed
        case invalidRequest // 400
        case authorizationError // 401
        case notFound // 404
        case internalError // 500
        case serverError // 502
        case serverUnavailable // 503
    }
    
    enum APIPathConstants: String {
        
        case mask = "raw.githubusercontent.com/kiang/pharmacies/master/json/points.json"
    }
}
