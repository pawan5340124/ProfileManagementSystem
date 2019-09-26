//
//  SceneDelegate.swift
//  ProfileManagementSystem
//
//  Created by Pawan Kumar on 26/09/19.
//  Copyright © 2019 Pawan_Kumar. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        self.SetNavigationRoot(windowScene: scene)
    }
    
     //AMRK: - SetRootController
     func SetNavigationRoot(windowScene : UIScene){
       /*
       //This function set Starting point of Project
       */
       let window = UIWindow(windowScene: windowScene as! UIWindowScene)
       let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
       if UserDefaults.standard.value(forKey: "logInData") != nil{
          window.rootViewController = storyBoard.instantiateViewController(withIdentifier: "RootnNavigationController") as! RootnNavigationController
       }else{
          window.rootViewController = storyBoard.instantiateViewController(withIdentifier: "RootnNavigationController") as! RootnNavigationController
       }
       self.window = window
       window.makeKeyAndVisible()
    }


}

