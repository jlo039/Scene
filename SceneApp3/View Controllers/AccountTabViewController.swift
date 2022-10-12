//
//  AccountTabViewController.swift
//  SceneApp3
//
//  Created by Jason Lott on 8/20/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AccountTabViewController: UIViewController {

    @IBOutlet weak var displayNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayNameLabel.text = Auth.auth().currentUser?.email
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
