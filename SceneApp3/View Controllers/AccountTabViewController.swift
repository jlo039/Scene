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
    
    @IBOutlet weak var InfoTest: UILabel!
    @IBOutlet weak var basicInfoStack: UIStackView!
    
    override func viewDidLoad() {
        
        
        // Define constraint for size of profile picture
        let proPicConstraint = NSLayoutConstraint(item: profileImageView!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: TopInfo, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 0.25, constant: 0)
        // Apply constraint
        TopInfo.addConstraint(proPicConstraint)
        
        // Access Firestore database and current user
        let db = Firestore.firestore()
        let signedInUid = Auth.auth().currentUser?.uid
        
        // Locate the current user's account info
        db.collection("users").document(signedInUid!).getDocument { (result, error) in
            if let document = result, document.exists {
                self.displayNameLabel.text = document.get("username") as? String
                self.accountTypeLabel.text = "User"
            } else {
                db.collection("artist").document(signedInUid!).getDocument { (result, error) in
                    if let document = result, document.exists {
                        self.displayNameLabel.text = document.get("stageName") as? String
                        self.accountTypeLabel.text = "Artist"
                    } else {
                        db.collection("venue").document(signedInUid!).getDocument { (result, error) in
                            if let document = result, document.exists {
                                self.displayNameLabel.text = document.get("venueName") as? String
                                self.accountTypeLabel.text = "Venue"
                            } else {
                                print("Document does not exist.")
                            }
                        }
                    }
                }
            }
            self.displayNameLabel.alpha = 1
            self.accountTypeLabel.alpha = 1
        }
        
        // Show user's profile picture
        profileImageView.image = UIImage(named:"AppIcon")
        
        super.viewDidLoad()
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func getUserDocument(accountType: String) {
        
    }
    

}
