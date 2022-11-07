//
//  NetworkingManagerUserResponseSuccessMock.swift
//  SwiftUISourceCodesTests
//
//  Created by Christopher Castillo on 9/8/22.
//

#if DEBUG
import Foundation

class NetworkingManagerUserResponseSuccessMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: EndPoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersModel.self) as! T
    }
    
    func request(session: URLSession, _ endpoint: EndPoint) async throws { }
    
}
#endif
