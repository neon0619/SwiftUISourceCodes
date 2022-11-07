//
//  EndPoint.swift
//  SwiftUISourceCodes
//
//  Created by Christopher Castillo on 8/25/22.
//

import Foundation

enum EndPoint {
    case people(page: Int)
    case detail(id: Int)
    case create(submissionData: Data?)
}

extension EndPoint {
    enum MethodType: Equatable {
        case GET
        case POST(data: Data?)
    }
}

extension EndPoint {
    var host: String { "reqres.in" }
    var path: String {
        switch self {
        case .people,
             .create:
            return "/api/users"
        case .detail(let id):
            return "/api/users/\(id)"
        }
    }
    var methodType: MethodType {
        switch self {
        case .people,
             .detail:
            return .GET
        case .create(let data):
            return .POST(data: data)
        }
    }
    var queryItems: [String: String]? {
        switch self {
        case .people(let page):
            return ["page":"\(page)"]
        default:
            return nil
        }
    }
}

extension EndPoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        var requestQueryItems = [URLQueryItem]()
        
        queryItems?.forEach { item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        
        #if DEBUG
        requestQueryItems.append(URLQueryItem(name: "delay", value: "4"))
        #endif
        urlComponents.queryItems = requestQueryItems
        
        return urlComponents.url
    }
}


