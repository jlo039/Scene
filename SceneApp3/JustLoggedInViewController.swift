//
//  JustLoggedInViewController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 11/9/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class JustLoggedInViewController: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //let PostTab = viewControllers?[0]
        let AccountTab = viewControllers?[3] as! AccountTabViewController
        //let FeedTab = viewControllers?[2]
        //let ExploreTab = viewControllers?[3]
        
        loadAccountScreen(AccountTab: AccountTab)
        
        // Do any additional setup after loading the view.
         
    }
    
    func loadAccountScreen(AccountTab: AccountTabViewController) {
        
        // Show user's profile picture
        let proPicConstraint = NSLayoutConstraint(item: AccountTab.profileImageView!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: AccountTab.TopInfo, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 0.25, constant: 0)
        AccountTab.TopInfo.addConstraint(proPicConstraint)
        AccountTab.profileImageView.image = UIImage(named:"AppIcon")
        
        // Access Firestore database and current user
        let db = Firestore.firestore()
        let signedInUid = Auth.auth().currentUser?.uid
        
        // Locate the current user's account info
        db.collection("users").document(signedInUid!).getDocument { (result, error) in
            if let document = result, document.exists {
                AccountTab.displayNameLabel.text = document.get("username") as? String
                AccountTab.accountTypeLabel.text = "User"
            } else {
                db.collection("artist").document(signedInUid!).getDocument { (result, error) in
                    if let document = result, document.exists {
                        AccountTab.displayNameLabel.text = document.get("stageName") as? String
                        AccountTab.accountTypeLabel.text = "Artist"
                    } else {
                        db.collection("venue").document(signedInUid!).getDocument { (result, error) in
                            if let document = result, document.exists {
                                AccountTab.displayNameLabel.text = document.get("venueName") as? String
                                AccountTab.accountTypeLabel.text = "Venue"
                            } else {
                                print("Document does not exist.")
                            }
                        }
                    }
                }
            }
            AccountTab.displayNameLabel.alpha = 1
            AccountTab.accountTypeLabel.alpha = 1
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
