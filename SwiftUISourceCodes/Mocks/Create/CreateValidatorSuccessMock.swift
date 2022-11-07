//
//  CreateValidatorSuccessMock.swift
//  SwiftUISourceCodesTests
//
//  Created by Christopher Castillo on 9/9/22.
//

#if DEBUG
import Foundation

struct CreateValidatorSuccessMock: CreateValidatorImpl {
    func validate(_ person: CreateModel) throws {}
}
#endif
