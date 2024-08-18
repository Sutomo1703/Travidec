//
//  Detailreportstatus.swift
//  Travidec
//
//  Created by Sutomo on 14/12/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class Detailreportstatus: UIViewController {

    private var db = Firestore.firestore()
    
    @IBOutlet weak var Tanggal: UILabel!
    @IBOutlet weak var Informername: UILabel!
    @IBOutlet weak var Subject: UILabel!
    @IBOutlet weak var Deskripsi: UILabel!
    @IBOutlet weak var Priority: UILabel!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var Latitude: UILabel!
    @IBOutlet weak var Longtitude: UILabel!
    var tanggalvar = String()
    var namavar = String()
    var subjectvar = String()
    var deskripsivar = String()
    var priorityvar = String()
    var statusvar = String()
    var latitudevar = String()
    var longtitudevar = String()
    var docid = String()
    var userid = String()
    
    @IBAction func Update(_ sender: UIButton) {
//        db.collection("reportData").document("sELzEN3ZbqfCfaS8r64o").setData(["status":"accepted"])
        showAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let docRef = db.collection("reportData").document(docid)
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
                    let user_id = document.data()?["user_id"] as? String
                    self.Informername.text = name
                    self.namavar = name!
                    self.Tanggal.text = tanggal
                    self.tanggalvar = tanggal!
                    self.Subject.text = sub
                    self.subjectvar = sub!
                    self.Deskripsi.text = desk
                    self.deskripsivar = desk!
                    self.Priority.text = prio
                    self.priorityvar = prio!
                    self.Status.text = stat
                    self.statusvar = stat!
                    self.Latitude.text = lat
                    self.latitudevar = lat!
                    self.Longtitude.text = long
                    self.longtitudevar = long!
                    self.userid = user_id!
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Update Status", message: "Do you want to Update the Status?", preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "Enter The Field"
            field.returnKeyType = .continue
            field.isSecureTextEntry = false
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: nil))
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            self.statusvar = (textField!.text ?? "Pending") as String
            self.db.collection("reportData").document(self.docid).setData([
                "name": self.namavar,
                "dateTime": self.tanggalvar,
                "subject": self.subjectvar,
                "description": self.deskripsivar,
                "priority": self.priorityvar,
                "locationLongitude": self.longtitudevar,
                "locationLatitude": self.latitudevar,
                "status": self.statusvar,
                "user_id": self.userid
            ]){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self.Status.text = self.statusvar
                }
            }
        }))
        
        present(alert, animated: true)
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
