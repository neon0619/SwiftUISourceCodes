//
//  Models.swift
//  SwiftUISourceCodes
//
//  Created by Christopher Castillo on 8/21/22.
//

// MARK: - User
struct User: Codable, Equatable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
}

// MARK: - Support
struct Support: Codable, Equatable {
    let url: String
    let text: String
}

