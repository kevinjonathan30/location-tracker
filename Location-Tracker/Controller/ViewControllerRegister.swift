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

    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textReenterPassword: UITextField!
    @IBAction func btnRegister(_ sender: UIButton) {
        if(textUsername.text != "" && textPassword.text != "" && textReenterPassword.text != "") {
            if(textPassword.text == textReenterPassword.text) {
                print("Register Success, Username: \(textUsername.text!), Password: \(textPassword.text!)")
            } else {
                print("Password doesn't match")
            }
        } else {
            print("Please fill the required field!")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
