//
//  PromotePostViewController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 1/27/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class PromotePostViewController: UIViewController {

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

        //
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        data = []
        dataSize = 0
        
        // Access event database
        Firestore.firestore().collection("events").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                // Update global var of existing events.
                for document in querySnapshot!.documents {
                    self.data.append(document.get("name") as! String)
                    self.dataSize += 1
                }
                appDelegate.eventNames = self.data
            }
        }
    }
    
    
    @IBAction func cancelNewPost(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func ExistingEvent(_ sender: Any) {
        // Open search view for existing events.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let existingEvents = storyboard.instantiateViewController(withIdentifier: "ExistingEvents")
        self.navigationController?.pushViewController(existingEvents, animated: true)
    }
    
    @IBAction func SumbitPromotion(_ sender: Any) {
        let db = Firestore.firestore()
        let eventName = EventNameEntry.text!
        if (!existing) {
            // Create new event on server
            let eventTime = Timestamp.init(date: EventDateEntry.date)
            let eventDescription = EventDescriptionEntry.text!
            db.collection("events").document("\(dataSize)").setData(["name": eventName, "date-time": eventTime, "description": eventDescription, "creator": Auth.auth().currentUser!.uid])
        }
        // Post promotion
        self.dismiss(animated: true)
        // Display "Successfully promoted" message
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
