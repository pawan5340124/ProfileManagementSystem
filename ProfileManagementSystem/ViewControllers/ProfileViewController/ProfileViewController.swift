//
//  ProfileViewController.swift
//  ProfileManagementSystem
//
//  Created by Pawan Kumar on 21/09/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import NVActivityIndicatorView
import SDWebImage

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NVActivityIndicatorViewable {

    //MARK: - Outlet
    @IBOutlet weak var imgProfilePicture: UIImageView!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtLincenceNumber: UITextField!
    @IBOutlet weak var txtBikeNumber: UITextField!
    @IBOutlet weak var txtAboutBike: UITextField!
    @IBOutlet weak var btnSaveProfile: UIButton!
    @IBOutlet weak var btnLogOut: UIButton!
    var imagePicker = UIImagePickerController()
    

    //MARK: -BasicFunction
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set UI changes
        self.SetUI()
        
        //Fetch profile data from firebase
        self.fetchProfileData()
    }
    
    func SetUI(){
        /*
        //This function set all UI
        */
        let userData = UserDefaults.standard.value(forKey: "logInData") as! NSDictionary
        self.txtEmail.text = userData["email"] as? String
        self.imgProfilePicture.layer.cornerRadius = self.imgProfilePicture.layer.frame.height / 2
        self.imgProfilePicture.clipsToBounds = true
        //set all field user interaction permission false
        self.UserInteractionHandel(Permission: false)
    }
    
    func UserInteractionHandel(Permission : Bool){
        /*
        //This function set edit permission of all filed
        */
        self.txtFullName.isUserInteractionEnabled = Permission
        self.txtAge.isUserInteractionEnabled = Permission
        self.txtLincenceNumber.isUserInteractionEnabled = Permission
        self.txtBikeNumber.isUserInteractionEnabled = Permission
        self.txtAboutBike.isUserInteractionEnabled = Permission
        self.btnEditProfile.isUserInteractionEnabled = Permission
    }
    
    //MARK: -ButtonAction
    @IBAction func btnEditProfile(_ sender: Any) {
        //Got Picture from gallery and camera
        self.ImageActionSheetOpen()
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        /*
        //logout button remove over store value and change root controller so user can login into new account
        */
         UserDefaults.standard.removeObject(forKey: "logInData")
         UserDefaults.standard.synchronize()
         let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let yourViewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
         let navigationController = self.view.window?.rootViewController as! UINavigationController
         navigationController.setViewControllers([yourViewController], animated: true)
    }
    
    @IBAction func btnSaveProfile(_ sender: Any) {
        if btnSaveProfile.titleLabel?.text == "Edit Profile"{
            self.btnSaveProfile.setTitle("Save Profile", for: .normal)
            //set all field user interaction permission true
            self.UserInteractionHandel(Permission: true)
        }
        else{
            let ProfileUpdateValidation = ProfileControllerCall.LogInValidation(name: self.txtFullName.text!, email: self.txtEmail.text!, age: self.txtAge.text!, licenceNumber: self.txtLincenceNumber.text!, bikeNumber: self.txtBikeNumber.text!, aboutBike: self.txtAboutBike.text!)
            if ProfileUpdateValidation == "Success"{
                      self.startAnimating(CGSize(width: 50, height:50), type: NVActivityIndicatorType.lineSpinFadeLoader, color: UIColor.init(red: 96/255, green: 101/255, blue: 143/255, alpha: 1), backgroundColor: UIColor.clear)
                      self.btnSaveProfile.setTitle("Edit Profile", for: .normal)
                             //set all field user interaction permission false
                      self.UserInteractionHandel(Permission: false)
                             //Upload User Image on firebase
                      self.UploadImage(Image: self.imgProfilePicture.image!)
            }else{
                      CommonFunctionCall.AlertShow(Title: "Alert", Message: ProfileUpdateValidation, View: self)
            }
        }
    }
    
    
    //MARK: -FirebaseFunction
    fileprivate func fetchProfileData(){
        /*
        //This function get complete profile info and store into model so user can use that info.
        */
        self.startAnimating(CGSize(width: 50, height:50), type: NVActivityIndicatorType.lineSpinFadeLoader, color: UIColor.init(red: 96/255, green: 101/255, blue: 143/255, alpha: 1), backgroundColor: UIColor.clear)
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let logInData = UserDefaults.standard.value(forKey: "logInData") as! NSDictionary
        ref.child("UserData").child(logInData["id"] as! String).observe(.value, with: { (snapshot) -> Void in
            self.stopAnimating()
                if let userData = snapshot.value as? [String:Any] {
                    let value = userData
                    let dataGot = ProfileData.init(fromDict: value)
                    self.txtFullName.text = dataGot.fullName
                    self.txtAge.text = dataGot.age
                    self.txtLincenceNumber.text = dataGot.licencePlate
                    self.txtBikeNumber.text = dataGot.bikeNumber
                    self.txtAboutBike.text = dataGot.aboutBike
                    self.imgProfilePicture.sd_setImage(with: URL(string: dataGot.imageUrl), placeholderImage: self.imgProfilePicture.image)
            }})
    }

    fileprivate func UploadImage(Image : UIImage){
        /*
        //This function can upload user profile in firebase and return that image url.
        */
        let data = Image.pngData()
        let storage = Storage.storage()
        let storageRef = storage.reference()
        // Create a reference to the file you want to upload
        let userData = UserDefaults.standard.value(forKey: "logInData") as! NSDictionary
        let gotUserId = userData["id"] as! String
        let createImageName = "images/" + gotUserId + ".jpg"
        let riversRef = storageRef.child(createImageName)
        _ = riversRef.putData(data!, metadata: nil) { (metadata, error) in
          riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              self.stopAnimating()
              return
            }
            //Now we have image url so we can store that data in firebase database
            self.UploadProfileData(ImageUrl: String(describing: downloadURL))
          }
        }
          
    }
    fileprivate func UploadProfileData(ImageUrl : String){
        /*
        //This function can upload user complete data in realtime firebase database.
        */
        let profileData : NSDictionary = ["ProfilePics":ImageUrl,"fullName":self.txtFullName.text!,"email":self.txtEmail.text!,"age":self.txtAge.text!,"licenceNumber":self.txtLincenceNumber.text!,"bikeNumber":self.txtBikeNumber.text!,"aboutBike":self.txtBikeNumber.text!]
        var ref2: DatabaseReference!
        ref2 = Database.database().reference()
        let userData = UserDefaults.standard.value(forKey: "logInData") as! NSDictionary
        ref2?.child("UserData").child(userData["id"] as! String).updateChildValues(profileData as! [AnyHashable : Any], withCompletionBlock: { (error, response) in
            self.stopAnimating()
            if (error != nil){
                CommonFunctionCall.AlertShow(Title: "Alert", Message: "Error occur please try again", View: self)
             }else{
                CommonFunctionCall.AlertShow(Title: "Alert", Message: "Profile updated successfully", View: self)
            }
          })}
}

//MARK: - Extension For Camera Access
extension ProfileViewController {
    func ImageActionSheetOpen(){
        /*
        //This function can open a action sheet and provide open like open camera or gallery
        */
        let alert:UIAlertController=UIAlertController(title: "", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCameraForImage()
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallaryForImage()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        // Add the actions
        imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            self.present(alert, animated: true, completion: nil)
        // It's an iPhone
        case .pad:
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: 0, y: self.view.bounds.size.height - 300, width: self.view.frame.size.width, height: 300)
            self.present(alert, animated: true, completion: nil)
        // It's an iPad
        default:
            alert.popoverPresentationController?.sourceView = self.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: 0, y: self.view.bounds.size.height - 300, width: self.view.frame.size.width, height: 300)
            self.present(alert, animated: true, completion: nil)
            // Uh, oh! What could it be?
        }
        
    }
    func openCameraForImage()
    {
        //Open Camera
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    func openGallaryForImage()
    {
        //open Gallery
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        //dismiss picker controller
        self.dismiss(animated: true, completion: nil)
        print("picker cancel.")
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //Got Image
            imgProfilePicture.image = originalImage
        }
        picker.dismiss(animated: true)
    }
}
