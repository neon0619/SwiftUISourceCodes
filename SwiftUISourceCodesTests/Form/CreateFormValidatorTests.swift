//
//  CreateFormValidatorTests.swift
//  SwiftUISourceCodesTests
//
//  Created by Christopher Castillo on 8/26/22.
//

import XCTest
@testable import SwiftUISourceCodes

class CreateFormValidatorTests: XCTestCase {
    
    private var validator: CreateValidator!
    
    override func setUp() {
        validator = CreateValidator()
    }
    
    override func tearDown() {
        validator = nil
    }

    func test_with_empty_person_first_name_error_thrown() {
        let person = CreateModel()
        
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty firstname should be thrown")
        
        do {
            _ = try validator.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidFirstName, "Expecting an error where we have an invalid first name")
        }
        
    }

    func test_with_empty_first_name_error_thrown() {
        let person = CreateModel(lastName: "Magiba", job: "Pilot")
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty firstname should be thrown")
        
        do {
            _ = try validator.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidFirstName, "Expecting an error where we have an invalid first name")
        }
        
    }
    
    func test_with_empty_last_name_error_thrown() {
        
        let person = CreateModel(firstName: "t0tep", job: "Pilot")
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty lastname should be thrown")
        
        do {
            _ = try validator.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidLastName, "Expecting an error where we have an invalid last name")
        }
        
    }
    
    func test_with_empty_job_error_thrown() {
        let person = CreateModel(firstName: "t0tep", lastName: "Magiba")
        XCTAssertThrowsError(try validator.validate(person), "Error for an empty job should be thrown")
        
        do {
            _ = try validator.validate(person)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidJob, "Expecting an error where we have an invalid job")
        }
    }
    
    func test_with_valid_person_error_thrown() {
        let person = CreateModel(firstName: "t0tep", lastName: "Magiba", job: "Pilot")
        do {
            _ = try validator.validate(person)
        } catch {
            XCTFail("No error should be thrown, since the person should be a valid object")
        }
    }

}
