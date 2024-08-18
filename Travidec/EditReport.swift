//
//  EditReport.swift
//  Travidec
//
//  Created by IOS on 12/10/21.
//

import UIKit
import FirebaseFirestore
import Firebase
import MapKit
import CoreLocation
import CoreLocationUI

class EditReport: UIViewController, CLLocationManagerDelegate{
    
    
    @IBOutlet weak var er_name: UITextField!
    @IBOutlet weak var er_subject: UITextField!
    @IBOutlet weak var er_dateTime: UILabel!
    @IBOutlet weak var er_desc: UITextField!
    
    private var db = Firestore.firestore()
    
    
    @IBOutlet weak var er_btn_high: UIButton!
    @IBOutlet weak var er_btn_medium: UIButton!
    @IBOutlet weak var er_btn_low: UIButton!
    
    //location
    @IBOutlet weak var er_longitude: UILabel!
    @IBOutlet weak var er_latitude: UILabel!
    
    @IBOutlet weak var er_mapView: MKMapView!
    
    let locationmanager = CLLocationManager()
    
    var temp_stats = String()
    var temp_priority = String()
    
    var prior = ""
    var high = "High"
    var med = "Medium"
    var low = "Low"
    
    var theBigPass = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationmanager.delegate = self
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.startUpdatingLocation()
        
        let docRef = db.collection("reportData").document(theBigPass)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                DispatchQueue.main.async
                {
                    //self.subject_arr.append(document.data()["name"] as! String)
                    self.er_name.text = document.data()?["name"] as? String
                    self.er_dateTime.text = document.data()?["dateTime"] as? String
                    self.er_subject.text = document.data()?["subject"] as? String
                    self.er_desc.text = document.data()?["description"] as? String
                    self.er_longitude.text = document.data()?["locationLongitude"] as? String
                    self.er_latitude.text = document.data()?["locationLatitude"] as? String
                    self.temp_stats = document.data()?["status"] as? String ?? "Pending"
                    self.prior = document.data()?["priority"] as? String ?? "Medium"
                    if(self.prior == self.low){
                        self.er_btn_low.isSelected = true
                        self.er_btn_high.isSelected = false
                        self.er_btn_medium.isSelected = false
                    }else if(self.prior == self.med){
                        self.er_btn_low.isSelected = false
                        self.er_btn_high.isSelected = false
                        self.er_btn_medium.isSelected = true
                    }else{
                        self.er_btn_low.isSelected = false
                        self.er_btn_high.isSelected = true
                        self.er_btn_medium.isSelected = false
                    }
                }
            } else {
                print("Document does not exist")
            }
        }

        
        if(prior == high)
        {
            prior = "High"
        }
        else if (prior == med)
        {
            prior = "Medium"
        }
        else {
            prior = "Low"
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if (segue.identifier == "editReportSegue") {
//                if let detailVC = segue.destination as? EditReport {
////                    let passed = (detailLabel?.label.stringValue)!
////                    detailVC.theBigPass = passed
//                    let passed = detailVC.theBigPass
//                    print(passed)
//                }
//            }
//        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editReportToDetailReport" {
            if let detailVC = segue.destination as? Detailreport {
                detailVC.theBigPass = theBigPass
            }
        }
    }
    
    @IBAction func er_btn_submit(_ sender: UIButton) {
        print(theBigPass)
        db.collection("reportData").document(theBigPass).setData([
            "name": er_name.text!,
            "dateTime": er_dateTime.text!,
            "subject": er_subject.text!,
            "description": er_desc.text!,
            "priority": prior,
            "locationLongitude": er_longitude.text!,
            "locationLatitude": er_latitude.text!,
            "status": temp_stats,
            "user_id": Auth.auth().currentUser?.uid ?? "nouser"
        ]){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                self.performSegue(withIdentifier: "editReportToDetailReport", sender: self)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locations[0].coordinate, span: span)
        er_mapView.setRegion(region, animated: true)
        er_mapView.showsUserLocation = true
        er_latitude.text = String(region.center.latitude)
        er_longitude.text = String(region.center.longitude)
        //print(region.center.latitude)
        //print(region.center.longitude)
        
    }
    
    
    @IBAction func et_btn_high_action(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            er_btn_medium.isSelected = false
            er_btn_low.isSelected = false
            prior = high
        } else {
            sender.isSelected = true
            er_btn_medium.isSelected = false
            er_btn_low.isSelected = false
            prior = high
        }
    }
    
    @IBAction func et_btn_medium_action(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            er_btn_high.isSelected = false
            er_btn_low.isSelected = false
            prior = med
        } else {
            sender.isSelected = true
            er_btn_high.isSelected = false
            er_btn_low.isSelected = false
            prior = med
        }
    }
    
    
    @IBAction func et_btn_low_action(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            er_btn_medium.isSelected = false
            er_btn_high.isSelected = false
            prior = low
        } else {
            sender.isSelected = true
            er_btn_medium.isSelected = false
            er_btn_high.isSelected = false
            prior = low
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
