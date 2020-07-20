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
    let location_manager = CLLocationManager()  // NEEDS to be declared globally so the permissions notification shows properly
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var curr_location: CLLocation!
        
        self.location_manager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            curr_location = self.location_manager.location
    
          //  print("Lat \(curr_location.coordinate.latitude)")
          // print("Long \(curr_location.coordinate.longitude)")
        } else {
            print("Did not receive user permission for location")
        }
    }
    
    @IBAction func add_lithic(_ sender: Any) {
        createFile()
    }
    
    func createFile() {
        let file = "file2.csv"
        let text = "some text"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let file_url = dir.appendingPathComponent(file)
            
            do {
                try text.write(to: file_url, atomically: false, encoding: String.Encoding.utf8)
            } catch {
                print("ERROR when trying to write to file")
            }
        }

    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
