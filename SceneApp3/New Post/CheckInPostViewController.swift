//
//  CheckInPostViewController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 4/7/23.
//

import UIKit
import FirebaseFirestore

class CheckInPostViewController: UIViewController {

    @IBOutlet weak var eventInfo: UILabel!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        
        var eventToPost = AppDelegate.Event()
        
        let eventDocRef = db.collection("events").document(SearchEventViewController.selectedEvent.docID)
        
        eventDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                DispatchQueue.main.async {
                    eventToPost.docID = document.documentID
                    eventToPost.name = document.get("name") as! String
                    eventToPost.artistID = document.get("artistID") as! String
                    eventToPost.venueID = document.get("venueID") as! String
                    eventToPost.description = document.get("description") as! String
                    eventToPost.date = document.get("date-time") as! Timestamp
                    eventToPost.creatorID = document.get("creatorID") as! String
                    print(eventToPost.description)
                }
            } else {
                print("Document does not exist")
            }
        }
        
        
    }
    

    @IBAction func cancelNewPost(_ sender: Any) {
        self.dismiss(animated: true)
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
