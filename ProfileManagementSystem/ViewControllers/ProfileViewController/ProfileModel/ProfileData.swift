//
//  ProfileData.swift
//  ProfileManagementSystem
//
//  Created by Pawan Kumar on 22/09/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation


struct ProfileData  {
    var fullName : String
    var email : String
    var age : String
    var licencePlate : String
    var bikeNumber : String
    var aboutBike : String
    var imageUrl : String
    
    init() {
        fullName = ""
        email = ""
        age = ""
        licencePlate = ""
        bikeNumber = ""
        aboutBike = ""
        imageUrl = ""
    }
    init(fromDict data:[String:Any]) {
        fullName = data["fullName"] as! String
        email = data["age"] as! String
        age = data["age"] as! String
        licencePlate = data["licenceNumber"] as! String
        bikeNumber = data["bikeNumber"] as! String
        aboutBike = data["aboutBike"] as! String
        imageUrl = data["ProfilePics"] as! String
    }

    
}
