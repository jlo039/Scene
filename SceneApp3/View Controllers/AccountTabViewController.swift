//
//  AccountTabViewController.swift
//  SceneApp3
//
//  Created by Jason Lott on 8/20/22.
//

import UIKit
import SwiftUI
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class AccountTabViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var SafeArea: UIStackView!
    @IBOutlet weak var TopInfo: UIStackView!
    @IBOutlet weak var profilePicIV: UIImageView!
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var errorL: UILabel!
    @IBOutlet weak var basicInfoStack: UIStackView!
    @IBOutlet weak var filterB: UIButton!
    var posts = ["All": true, "Promotions": true, "Checkins": true, "Recaps": true]
    
    public override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let filterMenu = UIMenu(title: "Filter", children: [
            UIAction(title: "All", state: .on) {_ in
                
                self.posts["All"]?.toggle()
            },
            UIAction(title: "Promotions", state: .on) {_ in
                self.posts["Promotions"]?.toggle()
            },
            UIAction(title: "Checkins", state: .on) {_ in
                self.posts["Promitions"]?.toggle()
            },
            UIAction(title: "Recaps", state: .on) {_ in
                self.posts["Promotions"]?.toggle()
            },
        ])
        filterB.menu = filterMenu

        
        
        // Define constraint for size of profile picture
        let proPicConstraint = NSLayoutConstraint(item: profilePicIV!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: TopInfo, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 0.25, constant: 0)
        // Apply constraint
        TopInfo.addConstraint(proPicConstraint)
        
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gesture:)))

        // add it to the image view;
        profilePicIV.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        profilePicIV.isUserInteractionEnabled = true
        
        profilePicIV.layer.borderWidth = 1.0
        profilePicIV.layer.masksToBounds = false
        profilePicIV.layer.borderColor = UIColor.white.cgColor
        profilePicIV.layer.cornerRadius = 44
        profilePicIV.clipsToBounds = true
        
        // update view
        self.profilePicIV.image = appDelegate.profilePic
        self.realNameLabel.text = appDelegate.firstName
        self.navigationItem.title = appDelegate.displayName
        switch appDelegate.type {
        case 2:
            self.accountTypeLabel.text = "Venue"
            break
        case 1:
            self.accountTypeLabel.text = "Artist"
            break
        default:
            self.accountTypeLabel.text = "Member"
        }
        super.viewDidLoad()
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    @IBAction func signOutB(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "LoginNavigationController")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        } catch let signOutError as NSError {
            showError(signOutError as! String)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }

        profilePicIV.image = image
        guard let imageData = image.pngData() else {
            return
        }
        let signedInUid = Auth.auth().currentUser?.uid
        let storage = Storage.storage().reference()
        // upload image data
        storage.child("profileImages/\(signedInUid ?? "file").png").putData(imageData, metadata: nil, completion: {_, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            storage.child("profileImages/\(signedInUid ?? "file").png").downloadURL(completion: {url, error in
                guard let url = url, error == nil else {
                    return
                }
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.photoURL = url
                changeRequest?.commitChanges { error in
                  // ...
                }
            })
        })


    }
    
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showError(_ message:String) {
        errorL.text = message
        errorL.alpha = 1
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
