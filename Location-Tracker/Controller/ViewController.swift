//
//  ViewController.swift
//  Location-Tracker
//
//  Created by IOS on 17/11/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var ref: DatabaseReference!
    let userDefaults = UserDefaults.standard

    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBAction func btnSignIn(_ sender: UIButton) {
        if(textUsername.text != "" && textPassword.text != "") {
            //print("Hello \(textUsername.text!), your password is \(textPassword.text!)")
            ref.child(textUsername.text!).observe(.value, with: { (snapshot) in
                if(snapshot.childrenCount > 0) {
                    let v = snapshot.value as! NSDictionary
                    //print(v as Any)
                    for (_,j) in v {
                        //print(j)
                        for (m,n) in j as! NSDictionary {
                            if(m as! String == "password") {
                                if(n as! String == self.textPassword.text!) {
                                    let alert = UIAlertController(title: "Login Success", message: "Anda terlogin sebagai \(self.textUsername.text!)", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: {
                                        (alert: UIAlertAction!) in self.performSegue(withIdentifier: "toMain", sender: self)
                                    }))
                                    self.present(alert, animated: true, completion: nil)
                                    //self.userDefaults.setValue(self.textUsername.text!, forKey: "username")
                                    
                                } else {
                                    let alert = UIAlertController(title: "Error", message: "Password salah!", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                } else {
                    let alert = UIAlertController(title: "Error", message: "Username salah!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
              }) { (error) in
                print(error.localizedDescription)
            }
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Please fill the required field!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        if(self.userDefaults.value(forKey: "username") != nil) {
            self.performSegue(withIdentifier: "toMain", sender: self)
        }
        // Do any additional setup after loading the view.
    }
}

