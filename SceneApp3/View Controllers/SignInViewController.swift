//
//  SignInViewController.swift
//  SceneApp3
//
//  Created by Jason Lott on 8/17/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore
import FirebaseStorage

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.EmailTextField.delegate = self
        self.PasswordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.EmailTextField:
            return self.PasswordTextField.becomeFirstResponder()
        default:
            SignInAction(self)
            return self.PasswordTextField.resignFirstResponder()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    @IBAction func SignInAction(_ sender: Any) {
        //validate text fields
        let errMsg = validateFields()
        if errMsg != nil {
            showError(errMsg!)
        } else {
            
            //clean inputs
            let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //sign in the user
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error != nil {
                    self.showError((error?.localizedDescription)!)
                } else {
                    //update user's info in app delegate
                    let user = Auth.auth().currentUser
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.displayName = user?.displayName
                    // get profile photo from firebase storage
                    let profPhotoRef = Storage.storage().reference(forURL: user!.photoURL?.absoluteString ?? "gs://sceneapp-48eb8.appspot.com/profileImages/chooseProfilePic.png")
                    profPhotoRef.getData(maxSize: 2048*2048) { data, error in
                        if let error = error {
                            print(error)
                        } else {
                            appDelegate.profilePic =  UIImage(data: data!)
                        }
                    }
//                    let task = URLSession.shared.dataTask(with: (user!.photoURL ?? URL(string: "gs://sceneapp-48eb8.appspot.com/profileImages/chooseProfilePic.jpg"))!, completionHandler: { data, _, error in
//                        guard let data = data, error == nil else {
//                            return
//                        }
//                        DispatchQueue.main.async {
//                            let image = UIImage(data: data)
//                            appDelegate.profilePic = image
//                        }
//                    })
//                    task.resume()
                    let db = Firestore.firestore()
                    let signedInUid = user!.uid
                    
                    // Locate the current user's account
                    let docRef = db.collection("users").document(signedInUid)
                    // Grab info from their account
                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            appDelegate.type = document.get("type") as? Int
                            appDelegate.firstName = document.get("firstName") as? String
                        } else {
                            print("Document does not exist")
                        }
                    }
                    
                    //transition views
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "HomeVC2")
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                }
            }
        }
    }
    
    func validateFields() -> String? {
        if EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        return nil
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let homeScreenViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeScreenViewController) as? HomeScreenViewController
        
        view.window?.rootViewController = homeScreenViewController
        view.window?.makeKeyAndVisible()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
