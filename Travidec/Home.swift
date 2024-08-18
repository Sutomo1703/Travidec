//
//  Home.swift
//  Travidec
//
//  Created by IOS on 12/11/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth


class Home: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var db = Firestore.firestore()
    @IBOutlet weak var tableView: UITableView!
    var id : String = String()
    var id_arr = [String]()
    var subject_arr = [String]()
    var dateTime_arr = [String]()
    var stats_arr = [String]()
    
    var list = [cellClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        get_Data()
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subject_arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! isiCell
        //cell.subject?.text = "Coba"
        cell.id.text = "ID : " + id_arr[indexPath.row]
        cell.subject.text = subject_arr[indexPath.row]
        cell.dateNTime.text = dateTime_arr[indexPath.row]
        cell.status.text = stats_arr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        id = id_arr[indexPath.row]
        performSegue(withIdentifier: "homeToDetailReport", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToDetailReport" {
            if let detailVC = segue.destination as? Detailreport {
                detailVC.theBigPass = id
            }
        }
    }
    
    func get_Data() {
        let docRef = db.collection("reportData").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                DispatchQueue.main.async {
                    for document in querySnapshot!.documents {
                        if(document.data()["user_id"] as? String == Auth.auth().currentUser?.uid){
                            self.id_arr.append(document.documentID)
                            self.subject_arr.append(document.data()["subject"] as! String)
                            self.dateTime_arr.append(document.data()["dateTime"] as! String)
                            self.stats_arr.append(document.data()["status"] as! String)
                            self.tableView.reloadData()
                        }
                    }
                }
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
