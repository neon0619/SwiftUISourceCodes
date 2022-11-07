//
//  CreateValidatorFailureMock.swift
//  SwiftUISourceCodesTests
//
//  Created by Christopher Castillo on 9/14/22.
//

#if DEBUG
import Foundation

struct CreateValidatorFailureMock: CreateValidatorImpl {
    func validate(_ person: CreateModel) throws {
        throw CreateValidator.CreateValidatorError.invalidFirstName
    }
}
#endif
