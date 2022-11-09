//
//  CreateAccountViewController.swift
//  SceneApp3
//
//  Created by Jason Lott on 8/17/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstNameField: TextField!
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var usernameField: TextField!
    @IBOutlet weak var passwordField: TextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var stageNameTF: TextField!
    @IBOutlet weak var venueNameTF: TextField!
    @IBOutlet weak var addressTF: TextField!
    
    var email: String = "", password: String = "", username: String = "", stageName: String = "", venueName: String = "" ,address: String = ""
    static var newUser: AuthDataResult? = nil, firstName: String = "", type: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if firstNameField != nil {
            self.firstNameField.delegate = self
        }
        if emailField != nil {
            self.emailField.delegate = self
        }
        if passwordField != nil {
            self.passwordField.delegate = self
        }
        if usernameField != nil {
            self.usernameField.delegate = self
        }
        if stageNameTF != nil {
            self.stageNameTF.delegate = self
        }
        if venueNameTF != nil {
            self.venueNameTF.delegate = self
        }
        if addressTF != nil {
            self.addressTF.delegate = self
        }
        if errorLabel != nil {
            errorLabel.alpha = 0
        }
    }
    
    @IBAction func memberSelected(_ sender: Any) {
        CreateAccountViewController.type = 0
    }
    
    @IBAction func artistSelected(_ sender: Any) {
        CreateAccountViewController.type = 1
    }
    
    @IBAction func venueSelected(_ sender: Any) {
        CreateAccountViewController.type = 2
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.firstNameField:
            return self.emailField.becomeFirstResponder()
        case self.emailField:
            return self.passwordField.becomeFirstResponder()
        case self.passwordField:
            nextB(self)
            return self.passwordField.resignFirstResponder()
        case self.venueNameTF:
            return self.addressTF.becomeFirstResponder()
        default:
            CreateAccountAction(self)
            return textField.resignFirstResponder()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func nextB(_ sender: Any) {
        // make sure all fields are filled out
        let err = validateFields1()
        if err != nil {
            showError(err!)
        } else {
            // get data from text fields and clean
            CreateAccountViewController.firstName = firstNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                //check for errors
                if err != nil {
                    //there was an error
                    let errorMsg = err?.localizedDescription
                    self.showError(errorMsg!)
                } else {

                    CreateAccountViewController.newUser = result!
                    // change views
                    self.performSegue(withIdentifier: "nextSegue", sender: nil)
                }
            }
        }
    }
    
    @IBAction func CreateAccountAction(_ sender: Any) {
        //validate fields
        var error: String? = ""
        if usernameField != nil {
            error = validateFields2()
        } else if stageNameTF != nil {
            error = validateFields3()
        } else {
            error = validateFields4()
        }
        if error != nil {
            showError(error!)
        } else {
            if usernameField != nil {
                username = usernameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            } else if stageNameTF != nil {
                stageName = stageNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                venueName = venueNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                address = addressTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            //user created sucessfully. store information
            let db = Firestore.firestore()
            switch CreateAccountViewController.type {
            case 0:
                db.collection("users").document(CreateAccountViewController.newUser!.user.uid).setData(["firstName" : CreateAccountViewController.firstName, "username" : self.username, "uid" : CreateAccountViewController.newUser!.user.uid]) { error in
                    if error != nil {
                        //show error messsage
                        let errorMsg = error?.localizedDescription
                        self.showError(errorMsg!)
                    }
                }
                break
            case 1:
                db.collection("artist").document(CreateAccountViewController.newUser!.user.uid).setData(["firstName" : CreateAccountViewController.firstName, "stageName" : self.stageName, "uid" : CreateAccountViewController.newUser!.user.uid]) { error in
                    if error != nil {
                        //show error messsage
                        let errorMsg = error?.localizedDescription
                        self.showError(errorMsg!)

                    }
                }
                break
            case 2:
                db.collection("venue").document(CreateAccountViewController.newUser!.user.uid).setData(["firstName" : CreateAccountViewController.firstName, "venueName" : self.venueName, "address" : address,"uid" : CreateAccountViewController.newUser!.user.uid]) { error in
                    if error != nil {
                        //show error messsage
                        let errorMsg = error?.localizedDescription
                        self.showError(errorMsg!)
                    }
                }
                break
            default :
                showError("Invalid account type.")
            }

            //transition to the home screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "HomeVC")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
    }
    
    //check to make sure the fields are correct. Returns nil if everything is correct and the error message if not.
    func validateFields1() -> String? {
        //check that all fields are filled
        if firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  || passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        return nil
    }
    func validateFields2() -> String? {
        //check that all fields are filled
        if usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        return nil
    }
    func validateFields3() -> String? {
        //check that all fields are filled
        if stageNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        return nil
    }
    func validateFields4() -> String? {
        //check that all fields are filled
        if venueNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || addressTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        return nil
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        /*let homeScreenViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeScreenViewController) as? HomeScreenViewController
        
        view.window?.rootViewController = homeScreenViewController
        view.window?.makeKeyAndVisible()*/
        //self.performSegue(withIdentifier: "enterHomeScreen", sender: self)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
