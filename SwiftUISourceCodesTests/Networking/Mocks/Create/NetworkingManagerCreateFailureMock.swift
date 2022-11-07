//
//  NetworkingManagerCreateFailureMock.swift
//  SwiftUISourceCodesTests
//
//  Created by Christopher Castillo on 9/14/22.
//

#if DEBUG
import Foundation

class NetworkingManagerCreateFailureMock: NetworkingManagerImpl {
    func request<T>(session: URLSession, _ endpoint: EndPoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: EndPoint) async throws {
        throw NetworkingManager.NetworkingError.invalidURL
    }
}
#endif
