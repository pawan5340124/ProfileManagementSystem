//
//  SignUpViewController.swift
//  ProfileManagementSystem
//
//  Created by Pawan Kumar on 21/09/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class SignUpViewController: UIViewController,NVActivityIndicatorViewable {

    //MARK: - Outlet
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    
    //MARK: - BasicFunction
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
  
    //MARK: - ButtonAction
    @IBAction func btnSignUp(_ sender: Any) {
        let signUpValidation = SignUpControllerCall.SignUpValidation(Email: self.txtEmail.text!, Password: self.txtPassword.text!, ConfirmPassword: self.txtConfirmPassword.text!)
          if signUpValidation == "Success"{
              self.SignUpAuthorization()
          }else{
              CommonFunctionCall.AlertShow(Title: "Alert", Message: signUpValidation, View: self)
          }
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - SignUpWithFireBase
    func SignUpAuthorization(){
        /*
        //This function can create new account using firebase authontication
        */
        self.startAnimating(CGSize(width: 50, height:50), type: NVActivityIndicatorType.lineSpinFadeLoader, color: UIColor.init(red: 96/255, green: 101/255, blue: 143/255, alpha: 1), backgroundColor: UIColor.clear)
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { authResult, error in
                   self.stopAnimating()
                   if error != nil{
                      // error occur
                      CommonFunctionCall.AlertShow(Title: "Alert", Message: "Error Occured", View: self)
                    }else{
                    // SignUp Success
                    self.txtEmail.text = ""
                    self.txtPassword.text = ""
                    self.txtConfirmPassword.text = ""
                    CommonFunctionCall.AlertShow(Title: "Alert", Message: "Sign up success", View: self)
                }}
    }


}
