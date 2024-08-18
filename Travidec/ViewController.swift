//
//  ViewController.swift
//  Travidec
//
//  Created by IOS on 26/11/21.
//
// wdiqdhqiwdhqwihduihdqi

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    let database = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        //addData()
        
    }
    
    func addData() {
        let db = Firestore.firestore()
        
        db.collection("reportData").document().setData([
            "name":"jhonny",
            "dateTime":"Minggu",
            "subject":"crash",
            "description":"crash",
            "priority":"Low"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    
    


}

