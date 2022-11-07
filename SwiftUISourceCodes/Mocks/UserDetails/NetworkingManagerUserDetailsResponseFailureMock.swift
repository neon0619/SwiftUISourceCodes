//
//  NetworkingManagerUserDetailsResponseFailureMock.swift
//  SwiftUISourceCodesTests
//
//  Created by Christopher Castillo on 9/9/22.
//

#if DEBUG
import Foundation

class NetworkingManagerUserDetailsResponseFailureMock: NetworkingManagerImpl {
    func request<T>(session: URLSession, _ endpoint: EndPoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidURL
    }
    
    func request(session: URLSession, _ endpoint: EndPoint) async throws {}

}
#endif
