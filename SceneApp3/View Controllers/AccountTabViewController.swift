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

    @IBOutlet weak var SafeArea: UIStackView!
    @IBOutlet weak var TopInfo: UIStackView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    
    @IBOutlet weak var InfoTest: UILabel!
    @IBOutlet weak var basicInfoStack: UIStackView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Define constraint for size of profile picture
        let proPicConstraint = NSLayoutConstraint(item: profileImageView!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: TopInfo, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 0.25, constant: 0)
        // Apply constraint
        TopInfo.addConstraint(proPicConstraint)
        
        // Access Firestore database and current user
        let db = Firestore.firestore()
        let signedInUid = Auth.auth().currentUser?.uid
        
        // Locate the current user's account
        let docRef = db.collection("users").document(signedInUid!)
        // Grab info from their account
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.realNameLabel.text = document.get("firstName") as? String
                self.displayNameLabel.text = document.get("username") as? String
            } else {
                print("Document does not exist")
            }
        }
        
        accountTypeLabel.text = "Artist"
        
        profileImageView.image = UIImage(named:"AppIcon")
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
