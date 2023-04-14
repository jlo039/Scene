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
    
    struct Event {
        var name: String
        var description: String
        var date: Date
        var creator: String
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        var eventToPost: Event
        
        eventInfo.text = SearchEventViewController.selectedEventID + "\n"
        
        
        
        let eventDocRef = Firestore.firestore().collection("events").document(SearchEventViewController.selectedEventID)
        
        eventDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                DispatchQueue.main.async {
                    eventToPost.name = document.get("name") as! String
                    eventToPost.description = document.get("description") as! String
                    eventToPost.date = document.get("date-time") as! Date
                    eventToPost.creator = document.get("creator") as! String
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
