//
//  LocateMeViewController.swift
//  okulrAssignment
//
//  Created by Sree Lakshman on 14/11/24.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class LocateMeViewController: UIViewController {
    
    var pinCode: String = ""
    

    @IBOutlet weak var mapView: MKMapView!
    let geocoder = CLGeocoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(pinCode)
        getPincode(pincode: pinCode)
    }
    
    func getPincode(pincode: String) {
        AF.request("https://api.postalpincode.in/pincode/\(pincode)").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("Full JSON:", json)

                // Get the "Division" from the first "PostOffice" element
                if let division = json[0]["PostOffice"][0]["Division"].string {
                    print("Division:", division)
                    self.showDivisionOnMap(division: division)
                } else {
                    print("Division not found.")
                }
                
            case .failure(let error):
                print("Error:", error.localizedDescription)
            }
        }
    }

    func showDivisionOnMap(division: String) {
        geocoder.geocodeAddressString(division) { placemarks, error in
            if let error = error {
                print("Geocoding error:", error.localizedDescription)
                return
            }

            guard let placemark = placemarks?.first,
                  let location = placemark.location else {
                print("Location not found.")
                return
            }

            let coordinate = location.coordinate
            print("Coordinates: \(coordinate.latitude), \(coordinate.longitude)")

            // Create a pin annotation
            let annotation = MKPointAnnotation()
            annotation.title = division
            annotation.coordinate = coordinate

            // Set the region to display on the map
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            self.mapView.setRegion(region, animated: true)
            self.mapView.addAnnotation(annotation)
        }
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
