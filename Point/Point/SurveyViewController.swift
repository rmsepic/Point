//
//  SurveyViewController.swift
//  Point
//
//  Created by Ryland Sepic on 7/15/20.
//  Copyright © 2020 Ryland Sepic. All rights reserved.
//

import CoreLocation
import MessageUI
import UIKit


class SurveyViewController: UIViewController, MFMailComposeViewControllerDelegate {
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
    
    /// Export the information from the CSV file
    @IBAction func export(_ sender: Any) {
        let file = getFilePath()
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [file], applicationActivities: nil)

        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
        ]

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func createFile() {
        let file = "file.csv"
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
    
    /// Function returns the file path for the stored CSV file
    func getFilePath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
