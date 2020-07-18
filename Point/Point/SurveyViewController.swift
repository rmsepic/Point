//
//  SurveyViewController.swift
//  Point
//
//  Created by Ryland Sepic on 7/15/20.
//  Copyright © 2020 Ryland Sepic. All rights reserved.
//

import CoreLocation
import UIKit

class SurveyViewController: UIViewController {
    let location_manager = CLLocationManager()  // NEEDS to be declared globally
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var curr_location: CLLocation!
        
        self.location_manager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            curr_location = self.location_manager.location
            print("Lat \(curr_location.coordinate.latitude)")
            print("Long \(curr_location.coordinate.longitude)")
        } else {
            print("Did not receive user permission for location")
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
