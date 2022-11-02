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
    @IBOutlet weak var typeSelector: UISegmentedControl!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstNameField.delegate = self
        self.emailField.delegate = self
        self.usernameField.delegate = self
        self.passwordField.delegate = self
        self.cityField.delegate = self
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.firstNameField:
            return self.usernameField.becomeFirstResponder()
        case self.usernameField:
            return self.emailField.becomeFirstResponder()
        case self.emailField:
            return self.passwordField.becomeFirstResponder()
        case self.passwordField:
            return self.cityField.becomeFirstResponder()
        default:
            CreateAccountAction(self)
            return self.cityField.resignFirstResponder()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func typeSelectorAction(_ sender: Any) {
        if typeSelector.selectedSegmentIndex == 0 {
            
        } else if typeSelector.selectedSegmentIndex == 1 {
            
        } else {
            
        }
    }
    
    
    @IBAction func CreateAccountAction(_ sender: Any) {
        //validate fields
        let error = validateFields()
        if error != nil {
            showError(error!)
        } else {
            //clean data
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let firstName = firstNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let username = usernameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let city = cityField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let type = typeSelector.selectedSegmentIndex
            //create the user
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                
                //check for errors
                if err != nil {
                    //there was an error
                    let errorMsg = err?.localizedDescription
                    self.showError(errorMsg!)
                } else {
                    //user created sucessfully. store information
                    let db = Firestore.firestore()
                    let uid = result!.user.uid
                    print(uid)
                    db.collection("users").document(uid).setData(["firstName" : firstName, "username" : username, "location" : city, "type" : type, "uid" : uid]) { error in
                        if error != nil {
                            //show error messsage
                            let errorMsg = error?.localizedDescription
                            self.showError(errorMsg!)
                        }
                    }
                    //transition to the home screen
                    //self.transitionToHome()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "HomeVC")
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                }
            }
            
            
        }
    }
    
    //check to make sure the fields are correct. Returns nil if everything is correct and the error message if not.
    func validateFields() -> String? {
        //check that all fields are filled
        if firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            cityField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
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
