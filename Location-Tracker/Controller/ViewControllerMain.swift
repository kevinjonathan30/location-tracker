//
//  ViewControllerMain.swift
//  Location-Tracker
//
//  Created by IOS on 22/11/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import MapKit

protocol backDelegate {
    func resetSignInStatus(data: Bool)
}

class ViewControllerMain: UIViewController, CLLocationManagerDelegate {
    
    var myUsername : String = ""
    var delegate: backDelegate?
    var locationManager: CLLocationManager!
    var latitude = ""
    var longitude = ""

    @IBOutlet weak var textUsername: UILabel!
    @IBAction func btnSaveLocation(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
        let currentDate = NSDate.now
        print(currentDate)
    }
    @IBAction func btnHapusDatabaseTracker(_ sender: UIButton) {
        self.myMap.removeAnnotations(self.myMap.annotations)
    }
    @IBAction func btnSignOut(_ sender: UIButton) {
        delegate?.resetSignInStatus(data:true)
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var myMap: MKMapView!
    var location: CLLocation! {
        didSet {
            latitude = "\(location.coordinate.latitude)"
            longitude = "\(location.coordinate.longitude)"
            print(latitude)
            print(longitude)
            let mapCoord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let latDelta: CLLocationDegrees = 0.01
            let lonDelta: CLLocationDegrees = 0.01
            let mapSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            let mapRegion = MKCoordinateRegion(center: mapCoord, span: mapSpan)
            self.myMap.setRegion(mapRegion, animated: true)
            let anotasi = MKPointAnnotation()
            anotasi.title = "My Location"
            anotasi.subtitle = "I'm here"
            anotasi.coordinate = mapCoord
            self.myMap.addAnnotation(anotasi)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        locationManager.stopUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        textUsername.text = "Hello, \(myUsername)!"
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let currentDate = NSDate.now
        print(currentDate)
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
