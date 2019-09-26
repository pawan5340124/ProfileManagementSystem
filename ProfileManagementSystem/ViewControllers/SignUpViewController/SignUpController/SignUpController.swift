//
//  SignUpController.swift
//  ProfileManagementSystem
//
//  Created by Pawan Kumar on 26/09/19.
//  Copyright © 2019 Pawan_Kumar. All rights reserved.
//

import Foundation

let SignUpControllerCall = SignUpController()
class SignUpController{

    func SignUpValidation(Email : String,Password : String,ConfirmPassword : String) -> String{
           if Email == ""{
            return "Please enter email"
           }else if CommonFunctionCall.CheckEmailValidation(TextFieldString: Email) == false{
            return "Please enter valid email"
           }else if Password == ""{
            return "Please enter password"
           }else if ConfirmPassword == ""{
            return "Please enter confirm password"
          }else if Password != ConfirmPassword{
            return "Confirm password not matched"
          }else{
            return "Success"
           }
    }
    
    
}
