//
//  JSONMapperTests.swift
//  SwiftUISourceCodesTests
//
//  Created by Christopher Castillo on 8/25/22.
//

import Foundation
import XCTest
@testable import SwiftUISourceCodes

class JSONMapperTest: XCTestCase {
    
    func test_with_valid_json_successfully_decoded() {
        XCTAssertNoThrow(try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersModel.self), "Mapper shouldn't throw an error")
        
        let userModel = try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersModel.self)
        XCTAssertNotNil(userModel, "User response shouldn't nil")
        
        XCTAssertEqual(userModel?.page, 1, "Page number should be 1")
        XCTAssertEqual(userModel?.data.count, 6, "Data count should be 6")
    }
    
    func test_with_missing_file_error_thrown() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "", type: UsersModel.self), "An error should be thrown")
        do {
            _ = try StaticJSONMapper.decode(file: "", type: UsersModel.self)
        } catch {
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("This is the wrong type of mapping error for missing files")
                return
            }
            XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToMapContents, "This should be a failed to get contents error")
        }
    }
    
    
    func test_with_invalid_file_error_thrown() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "", type: UsersModel.self), "An error should be thrown")
        do {
            _ = try StaticJSONMapper.decode(file: "", type: UsersModel.self)
        } catch {
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("This is the wrong type of mapping error for missing files")
                return
            }
            XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToMapContents, "This should be a failed to get contents error")
        }
    }

    
    func test_with_invalid_json_error_thrown() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "UsersStaticData", type: UserDetailModel.self), "An error should be thrown")
        
        do {
            _ = try StaticJSONMapper.decode(file: "UsersStaticData", type: UserDetailModel.self)
        } catch {
            if error is StaticJSONMapper.MappingError {
                XCTFail("Got the wrong type of error, expecting a system decoding error.")
            }
        }
    }
    
}
