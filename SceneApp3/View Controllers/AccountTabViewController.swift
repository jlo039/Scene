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

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var accountTypeLabel: UILabel!
    
    @IBOutlet weak var basicInfoStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basicInfoStack
        
        profileImageView.image = UIImage(named:"AppIcon")
        displayNameLabel.text = Auth.auth().currentUser?.email
        accountTypeLabel.text = "";
        // Do any additional setup after loading the view.
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
