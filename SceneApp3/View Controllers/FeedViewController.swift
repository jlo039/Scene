//
//  FeedViewController.swift
//  SceneApp3
//
//  Created by Jason Samuel Lott on 11/2/22.
//

import UIKit
import FirebaseStorage


class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var profilePicIV: UIImageView!
    

    @IBAction func chooseProfilePicB(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
    
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
