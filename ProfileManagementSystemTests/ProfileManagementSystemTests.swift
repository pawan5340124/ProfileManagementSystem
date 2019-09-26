//
//  ProfileManagementSystemTests.swift
//  ProfileManagementSystemTests
//
//  Created by Pawan Kumar on 26/09/19.
//  Copyright © 2019 Pawan_Kumar. All rights reserved.
//

import XCTest
@testable import ProfileManagementSystem

class ProfileManagementSystemTests: XCTestCase {

    
    func testEmailValidation(){
        let email : String = "Pk5340124@gmail.com"
        let emailStatus = CommonFunctionCall.CheckEmailValidation(TextFieldString: email)
        XCTAssertEqual(emailStatus, true)
        
    }
    
    func testLogInValidation(){
        let email : String = "Pk5340124@gmail.com"
        let password : String = "123456"
        let logInValidationStatus = LogInControllerCall.LogInValidation(Email: email, Password: password)
        XCTAssertEqual(logInValidationStatus, "Success")
        
        let wrongEmail : String = "abcdef"
        let logInValidationWithWrongEmailStatus = LogInControllerCall.LogInValidation(Email: wrongEmail, Password: password)
        XCTAssertEqual(logInValidationWithWrongEmailStatus, "Please enter valid email")
        
        let emptyEmail : String = ""
        let logInValidationWithEmptyEmailStatus = LogInControllerCall.LogInValidation(Email: emptyEmail, Password: password)
        XCTAssertEqual(logInValidationWithEmptyEmailStatus, "Please enter email")
        
        let emptyPassword : String = ""
        let logInValidationWithEmptyPasswordStatus = LogInControllerCall.LogInValidation(Email: email, Password: emptyPassword)
        XCTAssertEqual(logInValidationWithEmptyPasswordStatus, "Please enter password")
        
    }
    
    func testSignUpValidation(){
        let email : String = "Pk5340124@gmail.com"
        let password : String = "123456"
        let confirmPassword : String = "123456"
        let signUpValidationStatus = SignUpControllerCall.SignUpValidation(Email: email, Password: password, ConfirmPassword: confirmPassword)
        XCTAssertEqual(signUpValidationStatus, "Success")
        
        
        let emptyEmail : String = ""
        let signUpValidationWithEmptyEmailStatus = SignUpControllerCall.SignUpValidation(Email: emptyEmail, Password: password, ConfirmPassword: confirmPassword)
        XCTAssertEqual(signUpValidationWithEmptyEmailStatus, "Please enter email")
        
        
        let wrongEmail : String = "abced"
        let signUpValidationWithWrongEmailStatus = SignUpControllerCall.SignUpValidation(Email: wrongEmail, Password: password, ConfirmPassword: confirmPassword)
        XCTAssertEqual(signUpValidationWithWrongEmailStatus, "Please enter valid email")
        
        let emptyPassword : String = ""
        let signUpValidationWithEmptyPasswordStatus = SignUpControllerCall.SignUpValidation(Email: email, Password: emptyPassword, ConfirmPassword: confirmPassword)
        XCTAssertEqual(signUpValidationWithEmptyPasswordStatus, "Please enter password")
        
        let emptyConfirmPassword : String = ""
        let signUpValidationWithEmptyConfirmPasswordStatus = SignUpControllerCall.SignUpValidation(Email: email, Password: password, ConfirmPassword: emptyConfirmPassword)
        XCTAssertEqual(signUpValidationWithEmptyConfirmPasswordStatus, "Please enter confirm password")
        
        let confirmPasswordDifferente : String = "wer"
        let signUpValidationWithdifferenteConfirmPasswordStatus = SignUpControllerCall.SignUpValidation(Email: email, Password: password, ConfirmPassword: confirmPasswordDifferente)
        XCTAssertEqual(signUpValidationWithdifferenteConfirmPasswordStatus, "Confirm password not matched")
        

    }
    
    func testProfileValidation(){
        
        let name : String = "pawan"
        let email : String = "pk5340124@gmail.com"
        let age : String = "23"
        let licenceNumber : String = "lic345ty"
        let bikeNumber : String = "pk21hu"
        let AboutBike : String = "hi this is my lovely bike"
        let ProfileUpdateValidationStatus = ProfileControllerCall.LogInValidation(name: name, email: email, age: age, licenceNumber: licenceNumber, bikeNumber: bikeNumber, aboutBike: AboutBike)
        XCTAssertEqual(ProfileUpdateValidationStatus, "Success")

        let emptyName : String = ""
        let ProfileUpdateValidationWithEmptyNameStatus = ProfileControllerCall.LogInValidation(name: emptyName, email: email, age: age, licenceNumber: licenceNumber, bikeNumber: bikeNumber, aboutBike: AboutBike)
        XCTAssertEqual(ProfileUpdateValidationWithEmptyNameStatus, "Please enter full name")
        
        let emptyEmail : String = ""
        let ProfileUpdateValidationWithEmptyEmailStatus = ProfileControllerCall.LogInValidation(name: name, email: emptyEmail, age: age, licenceNumber: licenceNumber, bikeNumber: bikeNumber, aboutBike: AboutBike)
        XCTAssertEqual(ProfileUpdateValidationWithEmptyEmailStatus, "Please enter email")
        
        let emptyAge : String = ""
        let ProfileUpdateValidationWithEmptyAgeStatus = ProfileControllerCall.LogInValidation(name: name, email: email, age: emptyAge, licenceNumber: licenceNumber, bikeNumber: bikeNumber, aboutBike: AboutBike)
        XCTAssertEqual(ProfileUpdateValidationWithEmptyAgeStatus, "Please enter age")
        
        let emptyLicenceNumber : String = ""
        let ProfileUpdateValidationWithEmptyLicenceStatus = ProfileControllerCall.LogInValidation(name: name, email: email, age: age, licenceNumber: emptyLicenceNumber, bikeNumber: bikeNumber, aboutBike: AboutBike)
        XCTAssertEqual(ProfileUpdateValidationWithEmptyLicenceStatus, "Please enter licence number")
        
        let emptyBikeNumber : String = ""
        let ProfileUpdateValidationWithEmptyBikeStatus = ProfileControllerCall.LogInValidation(name: name, email: email, age: age, licenceNumber: licenceNumber, bikeNumber: emptyBikeNumber, aboutBike: AboutBike)
        XCTAssertEqual(ProfileUpdateValidationWithEmptyBikeStatus, "Please enter bike number")
        
        
        let emptyAboutBike : String = ""
        let ProfileUpdateValidationWithEmptyAboutBikeStatus = ProfileControllerCall.LogInValidation(name: name, email: email, age: age, licenceNumber: licenceNumber, bikeNumber: bikeNumber, aboutBike: emptyAboutBike)
        XCTAssertEqual(ProfileUpdateValidationWithEmptyAboutBikeStatus, "Please enter about bike")

        
    }

}
