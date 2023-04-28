//
//  PostViewController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 3/31/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class PromotionPostViewController: UIViewController {

    @IBOutlet weak var PostTextField: UITextField!
    @IBOutlet weak var EventPreview: UIView!
     
    @IBOutlet weak var eventInfo: UILabel!
    
    var selectedEvent = SearchEventViewController.selectedEvent
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        eventInfo.text = selectedEvent.name + "\n" + selectedEvent.description
        
    }
    
    @IBAction func cancelNewPost(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func createPost(_ sender: Any) {
        
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let db = Firestore.firestore()
        let eventPath = db.document("/events/\(selectedEvent.docID)")
        let creatorID = Auth.auth().currentUser!.uid
        let postTime = Timestamp.init()
        let postID = selectedEvent.docID + "\(postTime.nanoseconds)".prefix(4) + creatorID.prefix(4)
        let postText = PostTextField.text!
        
        db.collection("posts").document(postID).setData(["text": postText, "event": eventPath, "postTime": postTime, "creator": creatorID, "postType": 0])
        
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
