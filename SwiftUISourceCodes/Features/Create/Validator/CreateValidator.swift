//
//  CreateValidator.swift
//  SwiftUISourceCodes
//
//  Created by Christopher Castillo on 8/24/22.
//

import Foundation

protocol CreateValidatorImpl {
    func validate(_ person: CreateModel) throws
}

// Note: Create Generic Validator for all vm validations.
struct CreateValidator: CreateValidatorImpl {
    func validate(_ person: CreateModel) throws {
        
        if person.firstName.isEmpty {
            throw CreateValidatorError.invalidFirstName
        }
        
        if person.lastName.isEmpty {
            throw CreateValidatorError.invalidLastName
        }
        
        if person.job.isEmpty {
            throw CreateValidatorError.invalidJob
        }
        
    }
}

extension CreateValidator {
    enum CreateValidatorError: LocalizedError {
        case invalidFirstName
        case invalidLastName
        case invalidJob
    }
}

extension CreateValidator.CreateValidatorError {
    var errorDescription: String? {
        switch self {
        case .invalidFirstName:
            return "First name can't be empty"
        case .invalidLastName:
            return "Last name can't be empty"
        case .invalidJob:
            return "Job  can't be empty"
        }
    }
}
