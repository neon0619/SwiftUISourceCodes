//
//  UsersModel.swift
//  SwiftUISourceCodes
//
//  Created by Christopher Castillo on 8/21/22.
//

// MARK: - UserModel
struct UsersModel: Codable, Equatable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support
}
