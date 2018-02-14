//
//  EmailValidations.swift
//  EmailValidations
//
//  Created by Andrew Chupin on 14.02.2018.
//  Copyright © 2018 Andrew Chupin. All rights reserved.
//


import XCTest
@testable import EmailValidation

class LoginValidationTests: XCTestCase {

        // Given
    func testValidateLoginPositiveName() {
        let validator = LoginValidator()
        let name = "name"
        
        // When
        let isValid = validator.validate(value: name)
        
        // Than
        XCTAssertEqual(isValid, true)
    }
    
        // Given
    func testValidateLoginPositiveNameWithPoint() {
        let validator = LoginValidator()
        let name = "n.ame"
        
        // When
        let isValid = validator.validate(value: name)
        
        // Than
        XCTAssertEqual(isValid, true)
        
    }
    
    func testValidateLoginPositiveNameEndNumber() {
        // Given
        let validator = LoginValidator()
        let name = "name12"
        
        // When
        let isValid = validator.validate(value: name)
        
        // Than
        XCTAssertEqual(isValid, true)
        
    }
    
    func testValidateLoginPositiveNamePointAndNumber() {
        // Given
        let validator = LoginValidator()
        let name = "n.23ame.1"
        
        // When
        let isValid = validator.validate(value: name)
        
        // Than
        XCTAssertEqual(isValid, true)
        
    }
    
    func testValidateLoginPositiveNameEntire() {
        // Given
        let validator = LoginValidator()
        let name = "naaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"// == 32
        
        // When
        let isValid = validator.validate(value: name)
        
        // Than
        XCTAssertEqual(isValid, true)
        
    }
    
    
    // MARK: POSITIVE EMAIL
    
    
    func testValidateLoginPositiveEmail() {
        // Given
        let validator = LoginValidator()
        let email = "name@dgfs.aac"
        
        // When
        let isValid = validator.validate(value: email)
        
        // Than
        XCTAssertEqual(isValid, true)
    }
    
    func testValidateLoginPositiveEmailWithNumbers() {
        // Given
        let validator = LoginValidator()
        let email = "name@131.com"
        
        // When
        let isValid = validator.validate(value: email)
        
        // Than
        XCTAssertEqual(isValid, true)
    }
    
    
    func testValidateLoginPositiveEmailWithNumberOnFirstBit() {
        // Given
        let validator = LoginValidator()
        let email = "name23@dsadas.com"
        
        // When
        let isValid = validator.validate(value: email)
        
        // Than
        XCTAssertEqual(isValid, true)
    }
    
    
    
    func testValidateLoginPositiveEmailWithNumberOnFirstTwoBits() {
        // Given
        let validator = LoginValidator()
        let email = "name32@12dkjh.com"
        
        // When
        let isValid = validator.validate(value: email)
        
        // Than
        XCTAssertEqual(isValid, true)
    }
    
    
    
    func testValidateLoginPositiveEmailMinimal() {
        // Given
        let validator = LoginValidator()
        let email = "n@n.co"
        
        // When
        let isValid = validator.validate(value: email)
        
        // Than
        XCTAssertEqual(isValid, true)
    }
    
    
    // MARK: NEGATIVE NAME
    
    
    func testValidateLoginNegativeNameNil() {
        // Given
        let validator = LoginValidator()
        let name: String? = nil
        
        // When
        let isValid = validator.validate(value: name)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    
    func testValidateLoginNegativeNameEmpty() {
        // Given
        let validator = LoginValidator()
        let name = ""
        
        // When
        let isValid = validator.validate(value: name)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    
    func testValidateLoginNegativeNameManySpace() {
        // Given
        let validator = LoginValidator()
        let name = "    "
        
        // When
        let isValid = validator.validate(value: name)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    
    func testValidateLoginNegativeNameNumber() {
        // Given
        let validator = LoginValidator()
        let name = "1"
        
        // When
        let isValid = validator.validate(value: name)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    
    func testValidateLoginNegativeNameTwoSymbols() {
        // Given
        let validator = LoginValidator()
        let name = "as"
        
        // When
        let isValid = validator.validate(value: name)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    
    func testValidateLoginNegativeNameStartMinus() {
        // Given
        let validator = LoginValidator()
        let name = "-das"
        
        // When
        let isValid = validator.validate(value: name)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    
    func testValidateLoginNegativeNameStartPoint() {
        // Given
        let validator = LoginValidator()
        let name = ".name"
        
        // When
        let isValid = validator.validate(value: name)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    
    func testValidateLoginNegativeNameStartNumber() {
        // Given
        let validator = LoginValidator()
        let name = "12name"
        
        // When
        let isValid = validator.validate(value: name)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    
    func testValidateLoginNegativeNameManySymbols() {
        // Given
        let validator = LoginValidator()
        let name = "qwertyuiopasdfghjklzxcvbnmqwertyu" // > 32
        
        // When
        let isValid = validator.validate(value: name)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    
    // MARK: EMAIL NEGATIVE TEST
    
    
    func testValidateLoginNegativeEmailWithoutPoint() {
        // Given
        let validator = LoginValidator()
        let email = "a@d"
        
        // When
        let isValid = validator.validate(value: email)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    
    func testValidateLoginNegativeEmailDoubleEmail() {
        // Given
        let validator = LoginValidator()
        let email = "@@d"
        
        // When
        let isValid = validator.validate(value: email)
        
        // Than
        XCTAssertEqual(isValid, false)
    }

    
    func testValidateLoginNegativeEmailSpaceBetween() {
        // Given
        let validator = LoginValidator()
        let email = "  @   .com"
        
        // When
        let isValid = validator.validate(value: email)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    
    func testValidateLoginNegativeEmailSecondBitSpace() {
        // Given
        let validator = LoginValidator()
        let email = "name@   .d"
        
        // When
        let isValid = validator.validate(value: email)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    
    func testValidateLoginNegativeEmailStartPoint() {
        // Given
        let validator = LoginValidator()
        let email = ".name@dsadas.com"
        
        // When
        let isValid = validator.validate(value: email)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    
    func testValidateLoginNegativeEmailEndNumbers() {
        // Given
        let validator = LoginValidator()
        let email = "name@dsadas.123"
        
        // When
        let isValid = validator.validate(value: email)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    
    
    func testValidateLoginNegativeEmailOneSymbolAfterPoint() {
        // Given
        let validator = LoginValidator()
        let email = "name@ddsad.c"
        
        // When
        let isValid = validator.validate(value: email)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
    
    func testValidateLoginNegativeEmailManySymbol() {
        // Given
        let validator = LoginValidator()
        let email = "namenamenameme@namedsdsdsdsdsna.com" // > 32
        
        // When
        let isValid = validator.validate(value: email)
        
        // Than
        XCTAssertEqual(isValid, false)
    }
}
