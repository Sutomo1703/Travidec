//
//  Dashboardviewcontroller.swift
//  Travidec
//
//  Created by Sutomo on 14/12/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class Dashboardviewcontroller: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var db = Firestore.firestore()
    @IBOutlet weak var tableView: UITableView!
    
    var id : String = String()
    var id_arr = [String]()
    var informer_arr = [String]()
    var sub_arr = [String]()
    var pri_arr = [String]()
    
    var list = [cellClass2]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informer_arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! isiCell2
        cell.iduser.text = "ID : " + id_arr[indexPath.row]
        cell.namadash.text = informer_arr[indexPath.row]
        cell.subdash.text = sub_arr[indexPath.row]
        cell.pridash.text = pri_arr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        id = id_arr[indexPath.row]
        performSegue(withIdentifier: "dashboardToDetailReportStatus", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dashboardToDetailReportStatus" {
            if let detailVC = segue.destination as? Detailreportstatus {
                detailVC.docid = id
            }
        }
    }
    
    func get_Data() {
        let docRef = db.collection("reportData").getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                DispatchQueue.main.async {
                    for document in querySnapshot!.documents {
                        self.id_arr.append(document.documentID)
                        self.informer_arr.append(document.data()["name"] as! String)
                        self.sub_arr.append(document.data()["subject"] as! String)
                        self.pri_arr.append(document.data()["priority"] as! String)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        get_Data()
        // Do any additional setup after loading the view.
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
