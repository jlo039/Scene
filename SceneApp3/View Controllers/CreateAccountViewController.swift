//
//  CreateAccountViewController.swift
//  SceneApp3
//
//  Created by Jason Lott on 8/17/22.
//

import UIKit

class CreateAccountViewController: UIViewController {
    @IBOutlet weak var typeSelector: UISegmentedControl!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func typeSelectorAction(_ sender: Any) {
        if typeSelector.selectedSegmentIndex == 0 {
            print("user")
        } else if typeSelector.selectedSegmentIndex == 1 {
            print("artist")
        } else {
            print("venue")
        }
    }
    //check to make sure the fields are correct. Returns nil if everything is correct and the error message if not.
    private func validateFields() -> String? {
        //check that all fields are filled
        if firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            cityField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        //check if password is 
        return nil
    }
    @IBAction func CreateAccountAction(_ sender: Any) {
        //validate fields
        
        //create the user
        
        //transition to the home screen
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
