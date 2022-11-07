//
//  NetworkingEndpointTests.swift
//  SwiftUISourceCodesTests
//
//  Created by Christopher Castillo on 8/27/22.
//

import XCTest
@testable import SwiftUISourceCodes

class NetworkingEndpointTests: XCTestCase {

    func test_with_people_endpoint_request_is_valid() {
        let endpoint = EndPoint.people(page: 1)
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users", "The path should be /api/users")
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        XCTAssertEqual(endpoint.queryItems, ["page":"1"], "The query items should be page:1")
        
        XCTAssertEqual(endpoint.url, URL(string: "https://reqres.in/api/users?page=1&delay=4"), "The generated doesn't match our endpoint")
    }

    func test_with_detail_endpoint_request_is_valid() {
        
        let userId = 1
        let endpoint = EndPoint.detail(id: userId)
        
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users/\(userId)", "The path should be /api/users/\(userId)")
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        XCTAssertNil(endpoint.queryItems, "The queryItems should be nil")
        
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users/\(userId)?delay=4", "The generated doesn't match our endpoint")

    }

    func test_with_create_endpoint_request_is_valid() {
        
        let endpoint = EndPoint.create(submissionData: nil)

        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users", "The path should be /api/users/")
        XCTAssertEqual(endpoint.methodType, .POST(data: nil), "The method type should be POST")
        XCTAssertNil(endpoint.queryItems, "The queryItems should be nil")

        XCTAssertEqual(endpoint.url, URL(string: "https://reqres.in/api/users?delay=4"), "The generated doesn't match our endpoint")
    }

}
