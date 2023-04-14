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
        
        // Access event database
        appDelegate.refreshEvents()

    }
    
    @IBAction func setPostType(_ sender: UIButton) {
        
        // Set post type being made
        switch(sender) {
        case PromoteButton:
            NewPostViewController.postType = 0
            break
        case CheckInButton:
            NewPostViewController.postType = 1
            break
        case RecapButton:
            NewPostViewController.postType = 2
            break
        default:
            print("ERROR")
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
