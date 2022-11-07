//
//  CreateViewModelSuccessTests.swift
//  SwiftUISourceCodesTests
//
//  Created by Christopher Castillo on 9/9/22.
//

import XCTest
@testable import SwiftUISourceCodes

class CreateViewModelSuccessTests: XCTestCase {
    
    private var networkingMock: NetworkingManagerImpl!
    private var validationMock: CreateValidatorImpl!
    private var vm: CreateViewModel!

    override func setUp() {
        networkingMock = NetworkingManagerCreateSuccessMock()
        validationMock = CreateValidatorSuccessMock()
        vm = CreateViewModel(networkingManager: networkingMock, validator: validationMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        validationMock = nil
        vm = nil
    }
    
    func test_with_successful_response_submission_state_is_successful() async throws {
        XCTAssertNil(vm.state, "The view model state should not be nil initially")
        defer { XCTAssertEqual(vm.state, .successful, "The view model state should be successful") }
        await vm.create()
    }
    
}
