//
//  CreateEventViewController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 1/27/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class CreateEventViewController: UIViewController {

    @IBOutlet weak var EventDateEntry: UIDatePicker!
    @IBOutlet weak var EventNameEntry: UITextField!
    @IBOutlet weak var VenueEntry: UITextField!
    @IBOutlet weak var ArtistEntry: UITextField!
    @IBOutlet weak var EventList: UILabel!
    @IBOutlet weak var EventDescriptionEntry: UITextField!
    
    var existing: Bool = false
    var data: [String]! = []
    var dataSize: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    
    @IBAction func cancelNewEvent(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func CreateNewEvent(_ sender: Any) {
        let db = Firestore.firestore()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let eventName = EventNameEntry.text!
        if (!existing) {
            // Create new event on server
            let eventTime = Timestamp.init(date: EventDateEntry.date)
            let eventDescription = EventDescriptionEntry.text!
            db.collection("events").document("\(appDelegate.numEvents!)").setData(["name": eventName, "date-time": eventTime, "description": eventDescription, "creator": Auth.auth().currentUser!.uid])
        }
        
        SearchEventViewController.selectedEvent = eventName
    }
    
    /*@IBAction func SwitchType(_ sender: Any) {
        // If creating new event
        if (PromotionType.selectedSegmentIndex == 0) {
            EventNameEntry.placeholder = "Event name"
            EventDateEntry.isUserInteractionEnabled = true
            VenueEntry.isUserInteractionEnabled = true
            ArtistEntry.isUserInteractionEnabled = true
            EventDescriptionEntry.isUserInteractionEnabled = true
            VenueEntry.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            ArtistEntry.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            EventDescriptionEntry.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        // If promoting existing event
        else {
            EventNameEntry.placeholder = "Search for event"
            EventDateEntry.isUserInteractionEnabled = false
            VenueEntry.isUserInteractionEnabled = false
            ArtistEntry.isUserInteractionEnabled = false
            EventDescriptionEntry.isUserInteractionEnabled = false
            VenueEntry.backgroundColor = #colorLiteral(red: 0.9358691573, green: 0.9358690977, blue: 0.9358690977, alpha: 1)
            ArtistEntry.backgroundColor = #colorLiteral(red: 0.9358691573, green: 0.9358690977, blue: 0.9358690977, alpha: 1)
            EventDescriptionEntry.backgroundColor = #colorLiteral(red: 0.9358691573, green: 0.9358690977, blue: 0.9358690977, alpha: 1)
        }
    }*/
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}