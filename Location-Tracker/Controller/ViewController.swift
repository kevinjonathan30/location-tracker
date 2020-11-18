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

    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBAction func btnSignIn(_ sender: UIButton) {
        if(textUsername.text != "" && textPassword.text != "") {
            print("Hello \(textUsername.text!), your password is \(textPassword.text!)")
        }
        else {
            print("Please fill the required field!")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

