//
//  PostViewController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 3/31/23.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var PostTextField: UITextField!
    @IBOutlet weak var EventPreview: UIView!
    
    @IBOutlet weak var eventname: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventname.text = SearchEventViewController.selectedEvent
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
