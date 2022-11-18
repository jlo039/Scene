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
        profilePicIV.layer.borderWidth = 1.0
        profilePicIV.layer.masksToBounds = false
        profilePicIV.layer.borderColor = UIColor.white.cgColor
        profilePicIV.layer.cornerRadius = profilePicIV.frame.size.width / 2
        profilePicIV.clipsToBounds = true
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
            let url = URL(string: urlString) else {
                    return
            }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.profilePicIV.image = image
            }
        })
        task.resume()
        
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
        
        profilePicIV.image = image
        guard let imageData = image.pngData() else {
            return
        }
        let signedInUid = Auth.auth().currentUser?.uid
        // upload image data
        storage.child("profileImages/\(signedInUid ?? "file").png").putData(imageData, metadata: nil, completion: {_, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            self.storage.child("profileImages/\(signedInUid ?? "file").png").downloadURL(completion: {url, error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                print("Downlaod url: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
