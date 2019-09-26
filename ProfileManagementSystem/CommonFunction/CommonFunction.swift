//
//  CommonFunction.swift
//  ProfileManagementSystem
//
//  Created by Pawan Kumar on 22/09/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

let CommonFunctionCall = CommonFunction()
class CommonFunction{

    

    //MARK: - CommonFunction
    func AlertShow(Title : String,Message : String,View: UIViewController){
               let alert = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
               View.present(alert, animated: true, completion: nil)
               let when = DispatchTime.now() + 2.5
               DispatchQueue.main.asyncAfter(deadline: when)
               {
                   alert.dismiss(animated: true, completion: nil)
               }
        }
    
     func CheckEmailValidation(TextFieldString:String) -> Bool {
         let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
         let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
         return emailTest.evaluate(with: TextFieldString)
     }
    
    

    
    
    
}


