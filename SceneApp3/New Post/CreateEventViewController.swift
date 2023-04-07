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
            db.collection("events").document("\(appDelegate.numEvents)").setData(["name": eventName, "date-time": eventTime, "description": eventDescription, "creator": Auth.auth().currentUser!.uid])
        }
        
        SearchEventViewController.selectedEvent = eventName
        
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
