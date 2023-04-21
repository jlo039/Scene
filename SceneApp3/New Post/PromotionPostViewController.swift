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
     
    @IBOutlet weak var eventname: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            navigationItem.hidesBackButton = true
        eventname.text = SearchEventViewController.selectedEvent.name
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelNewPost(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func createPost(_ sender: Any) {
        let db = Firestore.firestore()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let eventPath = db.document("/events/0")
        if (true) {
            // Create new event on server
            let postTime = Timestamp.init()
            let postText = PostTextField.text!
            db.collection("posts").document("\(appDelegate.numEvents)").setData(["text": postText, "event": eventPath, "postTime": postTime, "creator": Auth.auth().currentUser!.uid])
        }
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
