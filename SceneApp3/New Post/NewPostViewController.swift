//
//  NewPostViewController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 1/5/23.
//

import UIKit
import FirebaseFirestore

class NewPostViewController: UIViewController {

    @IBOutlet weak var CancelPostButton: UIBarButtonItem!
    
    @IBOutlet weak var PromoteButton: UIButton!
    @IBOutlet weak var CheckInButton: UIButton!
    @IBOutlet weak var RecapButton: UIButton!
    
    
    static var postType: Int = -1
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        var data: [String]! = []
        appDelegate.numEvents = 0
        
        // Access event database
        Firestore.firestore().collection("events").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                // Update global var of existing events.
                for document in querySnapshot!.documents {
                    data.append(document.get("name") as! String)
                    self.appDelegate.numEvents += 1
                }
                self.appDelegate.eventNames = data
            }
        }
        
        self.isModalInPresentation = true

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func setPostType(_ sender: UIButton) {
        if (sender == PromoteButton) {
            NewPostViewController.postType = 0
        }
        else if (sender == CheckInButton) {
            NewPostViewController.postType = 1
        }
        else {
            NewPostViewController.postType = 2
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
