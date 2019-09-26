//
//  DashBoardModel.swift
//  ProfileManagementSystem
//
//  Created by Pawan Kumar on 21/09/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation

struct RideData  {
    var startingPoint : String
    var EndPoint : String
    var Speed : String
    var TotalDistance : String
    
    init() {
        startingPoint = ""
        EndPoint = ""
        Speed = ""
        TotalDistance = ""
    }
    init(fromDict data:[String:Any]) {
        startingPoint = data["startingPoint"] as! String
        EndPoint = data["EndPoint"] as! String
        Speed = data["Speed"] as! String
        TotalDistance = data["TotalDistance"] as! String
    }

    
}
