//
//  DashBoardViewController.swift
//  ProfileManagementSystem
//
//  Created by Pawan Kumar on 21/09/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView


class DashBoardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NVActivityIndicatorViewable {

    //MARK: - Outlet
    @IBOutlet weak var rideListTableView: UITableView!
    var Rides : [RideData] = []

    //MARK: - BasicFunction
    override func viewDidLoad() {
        super.viewDidLoad()
        //Fetch today ride data using firebase
        fetchRideData()
        
        //set table view delegate and register cell
        self.rideListTableView.register(UINib.init(nibName: "RideTableViewCell", bundle: nil), forCellReuseIdentifier: "RideTableViewCell")
        self.rideListTableView.delegate = self
        self.rideListTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    fileprivate func fetchRideData(){
        /*
        //This function can fetch today rides data from firebase database
        */
        self.startAnimating(CGSize(width: 50, height:50), type: NVActivityIndicatorType.lineSpinFadeLoader, color: UIColor.init(red: 96/255, green: 101/255, blue: 143/255, alpha: 1), backgroundColor: UIColor.clear)
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("RideData").observe(.childAdded, with: { (snapshot) -> Void in
            self.stopAnimating()
            if let rideData = snapshot.value as? [String:Any] {
                self.Rides = [RideData(fromDict: rideData)]
                self.rideListTableView.reloadData()
            }})
    }


    //MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rides.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.rideListTableView.dequeueReusableCell(withIdentifier: "RideTableViewCell", for: indexPath) as! RideTableViewCell
        cell.selectionStyle = .none
        cell.baseView.layer.cornerRadius = 10
        cell.baseView.layer.shadowColor = UIColor.black.cgColor
        cell.baseView.layer.shadowOpacity = 0.3
        cell.baseView.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.lblStartingPoint.text = "Starting point : " + Rides[indexPath.row].startingPoint
        cell.lblEndingPoint.text = "Ending point : " + Rides[indexPath.row].EndPoint
        cell.lblSpeed.text = "Average speed : " + Rides[indexPath.row].Speed
        cell.lblDistance.text = "Total distance : " + Rides[indexPath.row].TotalDistance
        
        return cell
    }
}
