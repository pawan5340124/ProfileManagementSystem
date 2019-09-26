//
//  LogInController.swift
//  ProfileManagementSystem
//
//  Created by Pawan Kumar on 26/09/19.
//  Copyright © 2019 Pawan_Kumar. All rights reserved.
//

import Foundation


let LogInControllerCall = LogInController()
class LogInController{
    
     func LogInValidation(Email : String,Password : String) -> String{
           if Email == ""{
                return "Please enter email"
            }else if CommonFunctionCall.CheckEmailValidation(TextFieldString: Email) == false{
                return "Please enter valid email"
            }else if Password == ""{
                return "Please enter password"
            }else{
               return "Success"
            }
     }
    
     

}
