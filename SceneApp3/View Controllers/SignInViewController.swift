//
//  SignInViewController.swift
//  SceneApp3
//
//  Created by Jason Lott on 8/17/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

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
        EmailTextField.resignFirstResponder()
        return PasswordTextField.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    @IBAction func SignInAction(_ sender: Any) {
        
        //validate text fields
        let errMsg = validateFields()
        if errMsg != nil {
            showError(errMsg!)
        }
        
        //clean inputs
        let email = EmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //sign in the user
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                self.showError((error?.localizedDescription)!)
            } else {
                self.transitionToHome()
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
