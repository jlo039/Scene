//
//  PromotePostViewController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 1/27/23.
//

import UIKit

class PromotePostViewController: UIViewController {

    @IBOutlet weak var PromotionType: UISegmentedControl!
    @IBOutlet weak var EventDateEntry: UIDatePicker!
    @IBOutlet weak var EventNameEntry: UITextField!
    @IBOutlet weak var VenueEntry: UITextField!
    @IBOutlet weak var ArtistEntry: UITextField!
    @IBOutlet weak var EventDescriptionEntry: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelNewPost(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func SumbitPromotion(_ sender: Any) {
        if (PromotionType.selectedSegmentIndex == 0) {
            // Create new event on server
        }
        // Post promotion
        self.dismiss(animated: true)
        // Display "Successfully promoted" message
    }
    
    @IBAction func SwitchType(_ sender: Any) {
        // If creating new event
        if (PromotionType.selectedSegmentIndex == 0) {
            EventNameEntry.placeholder = "Event name"
            EventDateEntry.isUserInteractionEnabled = true
            VenueEntry.isUserInteractionEnabled = true
            ArtistEntry.isUserInteractionEnabled = true
            EventDescriptionEntry.isUserInteractionEnabled = true
        }
        // If promoting existing event
        else {
            EventNameEntry.placeholder = "Search for event"
            EventDateEntry.isUserInteractionEnabled = false
            VenueEntry.isUserInteractionEnabled = false
            ArtistEntry.isUserInteractionEnabled = false
            EventDescriptionEntry.isUserInteractionEnabled = false
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
