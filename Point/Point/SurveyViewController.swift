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
    
    /// Personal information given at the beginning
    var user:String = ""
    var project: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createFile() // Crate the csv file which will be used
        
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
        writeToFile(text: "lithic")
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
        let text = "User,Project,Device,Artifact,Note,Latitude,Longitude,Error"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let file_url = dir.appendingPathComponent(file)
            
            do {
                try text.write(to: file_url, atomically: false, encoding: String.Encoding.utf8)
            } catch {
                print("ERROR when trying to write to file")
            }
        }
    }
    
    func writeToFile(text: String) {
        let file = self.user + "-" + self.project + ".csv"
        
        let curr_location:CLLocation! = self.location_manager.location
        let lat = String(curr_location.coordinate.latitude)
        let long = String(curr_location.coordinate.longitude)
        
        let line:String = self.user + "," + self.project + "," + text + ",TODO:note," + lat + "," + long + ",error"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let file_url = dir.appendingPathComponent(file)
            
            do {
                try line.write(to: file_url, atomically: false, encoding: String.Encoding.utf8)
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
