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
                    self.appDelegate.numEvents! += 1
                }
                self.appDelegate.eventNames = data
            }
        }
        
        self.isModalInPresentation = true
        
        //PromoteButton.tintColor = #colorLiteral(red: 0.3479217589, green: 0.4500026107, blue: 0.7300929427, alpha: 1)
        //PromoteButton.setImage(UIImage(systemName: "megaphone.fill"), for: UIControl.State.normal)
        
        CheckInButton.tintColor = #colorLiteral(red: 0.3479217589, green: 0.4500026107, blue: 0.7300929427, alpha: 1)
        CheckInButton.setImage(UIImage(systemName: "mappin.and.ellipse"), for: UIControl.State.normal)
        
        RecapButton.tintColor = #colorLiteral(red: 0.3479217589, green: 0.4500026107, blue: 0.7300929427, alpha: 1)
        RecapButton.setImage(UIImage(systemName: "camera.fill"), for: UIControl.State.normal)
        
        // Do any additional setup after loading the view.
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
