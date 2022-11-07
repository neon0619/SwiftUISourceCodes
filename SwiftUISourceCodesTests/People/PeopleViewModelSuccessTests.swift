//
//  PeopleViewModelSuccessTests.swift
//  SwiftUISourceCodesTests
//
//  Created by Christopher Castillo on 9/8/22.
//

import XCTest
@testable import SwiftUISourceCodes

class PeopleViewModelSuccessTests: XCTestCase {
    
    private var networkingMock: NetworkingManagerImpl!
    private var vm: PeopleViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerUserResponseSuccessMock()
        vm = PeopleViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }

    func test_with_sucessful_response_users_array_is_set() async throws {
        
        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
        defer {
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
            XCTAssertEqual(vm.viewState, .finished, "The viewModel viewState should be finished")
        }
        await vm.fetchUsers()
        XCTAssertEqual(vm.users.count, 6, "There should be 6 users within our data array")
    }
    
    func test_with_sucessful_paginated_response_users_array_is_set() async throws {

        XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
        defer {
            XCTAssertFalse(vm.isFetching, "The view model shouldn't be fetching any data")
            XCTAssertEqual(vm.viewState, .finished, "The viewModel viewState should be finished")
        }
        
        await vm.fetchUsers()
        XCTAssertEqual(vm.users.count, 6, "There should be 6 users within our data array")
        
        await vm.fetchNextSetofUsers()
        XCTAssertEqual(vm.users.count, 12, "There should be 12 users within our data array")
        XCTAssertEqual(vm.pageNum, 2, "The page should be 2")
    }
    
    func test_with_reset_called_values_is_reset() async throws {
        
        defer {
            XCTAssertEqual(vm.users.count, 6, "The users array shoud be return to 6")
            XCTAssertEqual(vm.pageNum, 1, "The page should be 1")
            XCTAssertEqual(vm.totalPages, 2, "The totalPages should be 2")
            XCTAssertEqual(vm.viewState, .finished, "The viewModel viewState should be finished")
            XCTAssertFalse(vm.isLoading, "The view model shouldn't be loading any data")
        }
        
        await vm.fetchUsers()
        XCTAssertEqual(vm.users.count, 6, "There should be 6 users within our data array")
        
        await vm.fetchNextSetofUsers()
        XCTAssertEqual(vm.users.count, 12, "There should be 12 users within our data array")
        XCTAssertEqual(vm.pageNum, 2, "The page should be 2")
        
        await vm.fetchUsers()
    }
    
    func test_with_last_user_func_returns_true() async {
        
        await vm.fetchUsers()
        let userData = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UsersModel.self)
        let hasReachedEnd = vm.hasReachedEnd(of: userData.data.last!)
        XCTAssertTrue(hasReachedEnd, "The last user should match")
    }

}
