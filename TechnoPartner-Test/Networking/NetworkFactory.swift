//
//  NetworkFactory.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import Foundation

enum NetworkFactory {
    //AUTH
    case doLogin(email: String, password: String)
}

extension NetworkFactory {
    
    // MARK: URL PATH API
    var path: String {
        switch self {
        case .doLogin:
            return "/oauth/token"
        }
    }
    
    // MARK: URL QUERY PARAMS / URL PARAMS
    var queryItems: [URLQueryItem] {
        switch self {
        case .doLogin:
            return []
        }
    }
    
    // MARK: BASE URL API
    var baseApi: String? {
        switch self {
        default:
            return "soal.staging.id"
        }
    }
    
    // MARK: URL LINK
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseApi
        let finalParams: [URLQueryItem] = self.queryItems
        components.path = path
        components.queryItems = finalParams
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    // MARK: HTTP METHOD
    var method: RequestMethod {
        switch self {
        case .doLogin:
            return .post
        default:
            return .get
        }
    }
    
    enum RequestMethod: String {
        case delete = "DELETE"
        case get = "GET"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
    }
    
    // MARK: BODY PARAMS API
    var bodyParam: [String: Any]? {
        switch self {
        case .doLogin(let email, let password):
            return ["email": email,
                    "password": password]
        default:
            return [:]
        }
    }
    
    // MARK: MULTIPART DATA
    var data: Data? {
        switch self {
        default:
            return Data()
        }
    }
    
    // MARK: HEADER API
    var headers: [String: String]? {
        switch self {
        case .doLogin:
            return getHeaders(type: .anonymous)
        }
    }
    
    // MARK: TYPE OF HEADER
    enum HeaderType {
        case anonymous
        case appToken
        case multiPart
    }
    
    func getBoundary() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    fileprivate func getHeaders(type: HeaderType) -> [String: String] {
        
        let appToken = ""
        
        var header: [String: String]
        
        switch type {
        case .anonymous:
            header = ["Content-Type": "application/json"]
        case .appToken:
            header = ["Content-Type": "application/json",
                      "Accept": "*/*",
                      "Authorization": "Bearer \(appToken ?? "")"]
        case .multiPart:
            header = ["Accept": "*/*",
                      "Authorization": "Bearer \(appToken ?? "")"]
        }
        return header
    }
    
    func createBodyWithParameters(parameters: [String: Any], imageDataKey: Data?, boundary: String)  -> Data {
        var body = Data()
        let filePath = "image"
        let fileName = "imagggee.jpg"
        let mimetype = "image/jpeg"
        let lineBreak = "\r\n"
        for (key, value) in parameters {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
            body.append("\(value)")
            body.append("\(lineBreak)")
        }
        
        body.append("\r\n--\(boundary)\r\n")
        
        if let imageDataKey, imageDataKey != Data() {
            body.append("Content-Disposition: form-data; name=\"\(filePath)\"; filename=\"\(fileName)\"\r\n")
            body.append("Content-Type: \(mimetype)\r\n\r\n")
            body.append(imageDataKey)
            body.append("\r\n--\(boundary)--\r\n")
        }
        return body
    }
    
    var urlRequestMultipart: URLRequest {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = method.rawValue
        let boundary = getBoundary()
        
        if let headers = headers {
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            headers.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let bodyParam, let data {
            urlRequest.httpBody =  createBodyWithParameters(parameters: bodyParam,
                                                            imageDataKey: data,
                                                            boundary: boundary)
        }
        return urlRequest
    }
    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: self.url)
        var bodyData: Data?
        urlRequest.httpMethod = method.rawValue
        if let header = headers {
            header.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let bodyParam = bodyParam, method != .get {
            do {
                bodyData = try JSONSerialization.data(withJSONObject: bodyParam, options: [.prettyPrinted])
                urlRequest.httpBody = bodyData
            } catch {
                // swiftlint:disable disable_print
#if DEBUG
                print(error)
#endif
                // swiftlint:enable disable_print
            }
        }
        return urlRequest
    }
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
}
