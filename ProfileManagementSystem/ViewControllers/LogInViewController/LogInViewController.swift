//
//  LogInViewController.swift
//  ProfileManagementSystem
//
//  Created by Pawan Kumar on 21/09/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class LogInViewController: UIViewController,NVActivityIndicatorViewable {

    //MARK: - Outlet
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    //MARK: - BasicFunction
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - ButtonAction
    @IBAction func btnLogin(_ sender: Any) {
        let logInValidation = LogInControllerCall.LogInValidation(Email: self.txtEmail.text!, Password: self.txtPassword.text!)
        if logInValidation == "Success"{
            self.SignInAuthorization()
        }else{
            CommonFunctionCall.AlertShow(Title: "Alert", Message: logInValidation, View: self)
        }
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        let viewControllerInstance = self.storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(viewControllerInstance, animated: true)
    }
    

    
    //MARK: - SignInWithFirebase
    func SignInAuthorization(){
        /*
        //This function authonticate your crediantail using firebase
        */
         self.startAnimating(CGSize(width: 50, height:50), type: NVActivityIndicatorType.lineSpinFadeLoader, color: UIColor.init(red: 96/255, green: 101/255, blue: 143/255, alpha: 1), backgroundColor: UIColor.clear)

         Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { [weak self] user, error in
             guard self != nil else { return }
              // ...
             self?.stopAnimating()
             if error != nil{
                 // error occur
                  CommonFunctionCall.AlertShow(Title: "Alert", Message: "Invalid credentials", View: self!)
             }
             else{
                // got user data
                let logInData = ["email" : (user?.user.email!)!,"id":(user?.user.uid)!]
                self?.LogInSuccess(logInData: logInData as NSDictionary)
             }
         }
    }
    
    
    //MARK: - LoginSuccess
    func LogInSuccess(logInData:NSDictionary){
        /*
        //This function change root controller so user can access app complete function.
        */
        UserDefaults.standard.set(logInData, forKey: "logInData")
        UserDefaults.standard.synchronize()
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let yourViewController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        let navigationController = self.view.window?.rootViewController as! UINavigationController
        navigationController.setViewControllers([yourViewController], animated: true)
    }
    

}

