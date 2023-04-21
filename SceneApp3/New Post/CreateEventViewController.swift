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

    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case EventNameEntry:
            return EventDateEntry.becomeFirstResponder()
        case EventDateEntry:
            return VenueEntry.becomeFirstResponder()
        case VenueEntry:
            return ArtistEntry.becomeFirstResponder()
        default:
            CreateNewEvent(self)
            return EventDescriptionEntry.resignFirstResponder()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelNewEvent(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func CreateNewEvent(_ sender: Any) {
        let db = Firestore.firestore()
        let eventID = "\(appDelegate.numEvents)"
        let eventName = EventNameEntry.text!
        let eventTime = Timestamp.init(date: EventDateEntry.date)
        let eventDescription = EventDescriptionEntry.text!

        if (!existing) {
            // Create new event on server
            db.collection("events").document(eventID).setData(["name": eventName, "artistID": "", "venueID": "", "date-time": eventTime, "description": eventDescription, "creatorID": Auth.auth().currentUser!.uid])
        }
        
        SearchEventViewController.selectedEvent = AppDelegate.Event(docID: eventID, name: eventName, description: eventDescription, date: eventTime, creatorID: Auth.auth().currentUser!.uid)
        
        var VCType: String = ""
        
        switch (NewPostViewController.postType) {
        case 0:
            VCType = "PostPromotion"
            break
        case 1:
            VCType = "PostCheckIn"
            break
        case 2:
            VCType = "PostRecap"
            break
        default:
            print("FAIL")
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createPostController = storyboard.instantiateViewController(withIdentifier: VCType)
        self.navigationController?.pushViewController(createPostController, animated: true)
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
