//
//  NetworkingManagerCreateSuccessMock.swift
//  SwiftUISourceCodesTests
//
//  Created by Christopher Castillo on 9/9/22.
//

#if DEBUG
import Foundation

class NetworkingManagerCreateSuccessMock: NetworkingManagerImpl {
    func request<T>(session: URLSession, _ endpoint: EndPoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: EndPoint) async throws {}
}
#endif
