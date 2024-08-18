//
//  LoginControllerViewController.swift
//  Travidec
//
//  Created by IOS on 12/13/21.
//

import UIKit
import FirebaseAuth

class LoginControllerViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        if(email.text != "" && password.text != ""){
            Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
               if error == nil{
                     print(Auth.auth().currentUser ?? "null")
                   if(Auth.auth().currentUser?.email == "admin@gmail.com"){
                       self.performSegue(withIdentifier: "loginToDashboard", sender: self)
                   }else{
                       self.performSegue(withIdentifier: "loginToHome", sender: self)
                   }
                }
                else{
                 let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
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
    
    @IBAction func register(_ sender: Any) {
        self.performSegue(withIdentifier: "loginToSignup", sender: self)
        
    }
}
