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
    var ref: DatabaseReference!
    var locationManager: CLLocationManager!
    var latitude : Double = 0
    var longitude : Double = 0

    @IBOutlet weak var textUsername: UILabel!
    @IBAction func btnSaveLocation(_ sender: UIButton) {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        let value = ["date": formatter.string(from: today), "latitude": latitude, "longitude": longitude] as [String : Any]
        ref.child(myUsername).child("savedLocations").childByAutoId().setValue(value)
        locationManager.startUpdatingLocation()
    }
    @IBAction func btnHapusDatabaseTracker(_ sender: UIButton) {
        let annotations = myMap.annotations.filter({ !($0 is MKUserLocation) })
        myMap.removeAnnotations(annotations)
        ref.child(myUsername).child("savedLocations").removeValue { (error, ref) in
            if error != nil {
                print("Error")
            }
        }
        locationManager.startUpdatingLocation()
    }
    @IBAction func btnSignOut(_ sender: UIButton) {
        delegate?.resetSignInStatus(data:true)
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var myMap: MKMapView!
    var location: CLLocation! {
        didSet {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            let mapCoord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let latDelta: CLLocationDegrees = 0.01
            let lonDelta: CLLocationDegrees = 0.01
            let mapSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            let mapRegion = MKCoordinateRegion(center: mapCoord, span: mapSpan)
            self.myMap.setRegion(mapRegion, animated: true)
            generateAnnotations()
        }
    }
    
    func generateAnnotations() {
        ref.child(myUsername).child("savedLocations").observe(.value, with: { (snapshot) in
            if(snapshot.childrenCount > 0) {
                let v = snapshot.value as! NSDictionary
                for (_,j) in v {
                    var latitudeTemp : Any = 0
                    var longitudeTemp : Any = 0
                    for (m,n) in j as! NSDictionary {
                        if(m as! String == "latitude") {
                            latitudeTemp = n
                        }
                        if(m as! String == "longitude") {
                            longitudeTemp = n
                        }
                    }
                    let annotations = MKPointAnnotation()
                    annotations.title = "Pinned"
                    annotations.coordinate = CLLocationCoordinate2D(latitude: latitudeTemp as! CLLocationDegrees, longitude: longitudeTemp as! CLLocationDegrees)
                    self.myMap.addAnnotation(annotations)
                }
            }
          }) { (error) in
            print(error.localizedDescription)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        locationManager.stopUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        ref = Database.database().reference()
        textUsername.text = "Hello, \(myUsername)!"
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
