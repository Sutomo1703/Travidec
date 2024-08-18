//
//  Detailreport.swift
//  Travidec
//
//  Created by Sutomo on 14/12/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase
class Detailreport: UIViewController {

    private var db = Firestore.firestore()
    var theBigPass = String()
    @IBOutlet weak var Informeruser: UILabel!
    @IBOutlet weak var Tanggaluser: UILabel!
    @IBOutlet weak var Subjectuser: UILabel!
    @IBOutlet weak var Deskripsiuser: UILabel!
    @IBOutlet weak var Priorityuser: UILabel!
    @IBOutlet weak var Statususer: UILabel!
    @IBOutlet weak var Latitudeuser: UILabel!
    @IBOutlet weak var Longtitudeuser: UILabel!
    @IBAction func Edit(_ sender: UIButton) {
        performSegue(withIdentifier: "detailReportToEditReport", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let docRef = db.collection("reportData").document(theBigPass)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                DispatchQueue.main.async {
                    let name = document.data()?["name"] as? String
                    let tanggal = document.data()?["dateTime"] as? String
                    let sub = document.data()?["subject"] as? String
                    let desk = document.data()?["description"] as? String
                    let prio = document.data()?["priority"] as? String
                    let stat = document.data()?["status"] as? String
                    let lat = document.data()?["locationLatitude"] as? String
                    let long = document.data()?["locationLongitude"] as? String
                    self.Informeruser.text = name
                    self.Tanggaluser.text = tanggal
                    self.Subjectuser.text = sub
                    self.Deskripsiuser.text = desk
                    self.Priorityuser.text = prio
                    self.Statususer.text = stat
                    self.Latitudeuser.text = lat
                    self.Longtitudeuser.text = long
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailReportToEditReport" {
            if let detailVC = segue.destination as? EditReport {
                detailVC.theBigPass = theBigPass
            }
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
