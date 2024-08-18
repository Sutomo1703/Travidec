//
//  EditProfileViewController.swift
//  Travidec
//
//  Created by IOS on 12/14/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

let datePicker = UIDatePicker()
let db = Firestore.firestore()

class EditProfileViewController: UIViewController {
    @IBOutlet weak var fname : UITextField!
    @IBOutlet weak var lname : UITextField!
    @IBOutlet weak var birthdate : UITextField!
    @IBOutlet weak var phone : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        let docRef = db.collection("users").document(Auth.auth().currentUser!.uid)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                DispatchQueue.main.async
                {
                    let name = document.data()?["name"] as? String
                    let name_ar = name?.components(separatedBy: " ")
                    self.fname.text = name_ar?[0]
                    self.lname.text = name_ar?[1]
                    self.birthdate.text = document.data()?["birthdate"] as? String
                    self.phone.text = document.data()?["phone"] as? String
                }
            } else {
                print("Document does not exist")
            }
        // Do any additional setup after loading the view.
        }
    }

    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        birthdate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }


    func createDatePicker(){
        birthdate.textAlignment = .center

        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)

        birthdate.inputAccessoryView = toolbar

        birthdate.inputView = datePicker

        datePicker.datePickerMode = .date
    }

    @IBAction func submit(sender : Any){
        db.collection("users").document(Auth.auth().currentUser!.uid).setData([
            "name": self.fname.text! + " " + self.lname.text!,
            "uid" : Auth.auth().currentUser?.uid ?? "null",
            "birthdate" : birthdate.text!,
            "phone" : phone.text!
        ]){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                self.performSegue(withIdentifier: "editprofileToProfile", sender: self)
            }
        }
    }
}
