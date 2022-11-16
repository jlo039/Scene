//
//  FeedViewController.swift
//  SceneApp3
//
//  Created by Jason Samuel Lott on 11/2/22.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

class FeedViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var profilePicIV: UIImageView!
    @IBOutlet weak var errorL: UILabel!
    private let storage = Storage.storage().reference()
    
    @IBAction func chooseProfilePicB(_ sender: Any) {
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
        guard let imageData = image.pngData() else {
            return
        }
        
        storage.child("images/file.png").putData(imageData, metadata: nil, completion: {_, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            self.storage.child("images/file.png").downloadURL(completion: {url, error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                print("Downlaod url: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
            })
        })
        // upload image data
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func showError(_ message:String) {
        errorL.text = message
        errorL.alpha = 1
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
