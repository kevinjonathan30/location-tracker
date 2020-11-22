//
//  ViewControllerRegister.swift
//  Location-Tracker
//
//  Created by IOS on 18/11/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerRegister: UIViewController {
    
    var ref: DatabaseReference!

    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textReenterPassword: UITextField!
    @IBAction func btnRegister(_ sender: UIButton) {
        if(textUsername.text != "" && textPassword.text != "" && textReenterPassword.text != "") {
            if(textPassword.text == textReenterPassword.text) {
                let value = ["username": textUsername.text!,	"password": textPassword.text!]
                ref.child(textUsername.text!).child("userProfile").setValue(value)
                let alert = UIAlertController(title: "Register Success", message: "Registration is done, Username: \(textUsername.text!)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Password doesn't match", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please fill the required field!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
}
