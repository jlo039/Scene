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
                    
                    db.collection("users").addDocument(data: ["firstName" : firstName, "username" : username, "location" : city, "type" : type, "uid" : result!.user.uid]) { error in
                        if error != nil {
                            //show error messsage
                            self.showError("Error saving user data.")
                        }
                    }
                    //transition to the home screen
                    self.transitionToHome()
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
        errorLabel.isHidden = false
    }
    
    func transitionToHome() {
        let homeScreenViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.homeScreenViewController) as? HomeScreenViewController
        
        view.window?.rootViewController = homeScreenViewController
        view.window?.makeKeyAndVisible()
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
