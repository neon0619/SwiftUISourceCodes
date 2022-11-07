//
//  NetworkingManagerUserDetailsResponseSuccessMock.swift
//  SwiftUISourceCodesTests
//
//  Created by Christopher Castillo on 9/9/22.
//

#if DEBUG
import Foundation

class NetworkingManagerUserDetailsResponseSuccessMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: EndPoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailModel.self) as! T
    }

    func request(session: URLSession, _ endpoint: EndPoint) async throws { }
    
}
#endif


