//
//  ProfileController.swift
//  ProfileManagementSystem
//
//  Created by Pawan Kumar on 26/09/19.
//  Copyright © 2019 Pawan_Kumar. All rights reserved.
//

import Foundation


let ProfileControllerCall = ProfileController()
class ProfileController{


    func LogInValidation(name : String,email : String,age : String,licenceNumber : String,bikeNumber : String,aboutBike : String) -> String{
          if name == ""{
               return "Please enter full name"
           }else if email == ""{
               return "Please enter email"
           }else if age == ""{
               return "Please enter age"
          }else if licenceNumber == ""{
               return "Please enter licence number"
          } else if bikeNumber == ""{
               return "Please enter bike number"
          }else if aboutBike == ""{
               return "Please enter about bike"
          }else{
               return "Success"
           }
    }
    
}
