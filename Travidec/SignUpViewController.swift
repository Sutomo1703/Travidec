//
//  SignUpViewController.swift
//  Travidec
//
//  Created by IOS on 12/10/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var birthdate: UITextField!
    @IBOutlet weak var phone: UITextField!
    private var db = Firestore.firestore()
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        // Do any additional setup after loading the view.
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
    
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        birthdate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    @IBAction func register(_ sender: Any) {
        if(fname.text != "" && lname.text != "" && email.text != "" && password.text != "" && confirmPassword.text != "" && birthdate.text != "" && phone.text != "" && password.text == confirmPassword.text){
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ [self] (user, error) in
                if error == nil {
                    self.db.collection("users").document(Auth.auth().currentUser!.uid).setData([
                        "name": self.fname.text! + " " + self.lname.text!,
                        "uid" : Auth.auth().currentUser?.uid ?? "null",
                        "birthdate" : birthdate.text!,
                        "phone" : phone.text!
                    ]){ err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                            self.performSegue(withIdentifier: "signupToHome", sender: self)
                        }
                    }
                }
                else{
                   let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    print(error!)
                   let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)

                }
            }
        }else{
            let alertController = UIAlertController(title: "Input Invalid", message: "Please check your inputs", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)

        }
    }
}
