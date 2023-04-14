//
//  CheckInPostViewController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 4/7/23.
//

import UIKit

class CheckInPostViewController: UIViewController {

    @IBOutlet weak var eventInfo: UILabel!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        eventInfo.text = SearchEventViewController.selectedEvent + "\n"
        
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
