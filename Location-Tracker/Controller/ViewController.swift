//
//  ViewController.swift
//  Location-Tracker
//
//  Created by IOS on 17/11/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, backDelegate {
    
    var ref: DatabaseReference!
    let userDefaults = UserDefaults.standard

    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    func resetSignInStatus(data: Bool) {
        self.userDefaults.removeObject(forKey: "username")
    }
    @IBAction func btnSignIn(_ sender: UIButton) {
        if(textUsername.text != "" && textPassword.text != "") {
            ref.child(textUsername.text!).observe(.value, with: { (snapshot) in
                if(snapshot.childrenCount > 0) {
                    let v = snapshot.value as! NSDictionary
                    for (_,j) in v {
                        for (m,n) in j as! NSDictionary {
                            if(m as! String == "password") {
                                if(n as! String == self.textPassword.text!) {
                                    self.userDefaults.setValue(self.textUsername.text!, forKey: "username")
                                    let alert = UIAlertController(title: "Login Success", message: "Anda terlogin sebagai \(self.textUsername.text!)", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: {
                                        (alert: UIAlertAction!) in self.performSegue(withIdentifier: "toMain", sender: self)
                                    }))
                                    self.present(alert, animated: true, completion: nil)
                                    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMain" {
            let vcMain = segue.destination as! ViewControllerMain
            vcMain.myUsername = self.userDefaults.value(forKey: "username") as! String
            vcMain.delegate = self
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

