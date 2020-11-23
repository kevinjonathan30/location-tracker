//
//  ViewControllerMain.swift
//  Location-Tracker
//
//  Created by IOS on 22/11/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit

protocol backDelegate {
    func resetSignInStatus(data: Bool)
}

class ViewControllerMain: UIViewController {
    
    var myUsername : String = ""
    var delegate: backDelegate?

    @IBOutlet weak var textUsername: UILabel!
    @IBAction func btnSaveLocation(_ sender: UIButton) {
    }
    @IBAction func btnHapusDatabaseTracker(_ sender: UIButton) {
    }
    @IBAction func btnSignOut(_ sender: UIButton) {
        delegate?.resetSignInStatus(data:true)
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        textUsername.text = "Hello, \(myUsername)!"
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
