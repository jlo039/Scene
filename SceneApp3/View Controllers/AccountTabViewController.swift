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
        super.viewDidLoad()
        //var safeX = SafeArea.frame.width
        //var safeY = SafeArea.frame.height
        
        let proPicConstraint = NSLayoutConstraint(item: profileImageView!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: TopInfo, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 0.25, constant: 0)
        
        TopInfo.addConstraint(proPicConstraint)
        
        profileImageView.image = UIImage(named:"AppIcon")
        displayNameLabel.text = Auth.auth().currentUser?.uid
        accountTypeLabel.text = "";
        // Do any additional setup after loading the view.
        
        struct UserDocument {
            var docID = ""
            var uid = ""
            var firstName = ""
            var username = ""
            var location = ""
            var type = 0
        }
        
        let db = Firestore.firestore()
        let signedInUid = Auth.auth().currentUser?.uid
        
        let docRef = db.collection("users").document(_: signedInUid!)
        
        
        docRef.getDocument { (document, err) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print(dataDescription)
            } else {
                print("Does not exist")
            }
        }
        
        /*
        db.collection("users").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents")
            }
            else {
                var users: [UserDocument] = []
                for document in snapshot!.documents {
                    let docID = document.documentID
                    let firstName = document.get("firstName")
                    let location = document.get("location")
                    let type = document.get("type")
                    let uid = document.get("uid")
                    let username = document.get("username")
                    users.append(UserDocument(docID: docID, uid: uid, firstName: firstName, username: username, location: location, type: type))
                }
            }
        }
        */
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
