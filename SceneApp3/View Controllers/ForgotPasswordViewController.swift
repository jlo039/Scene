//
//  ForgotPasswordViewController.swift
//  SceneApp3
//
//  Created by Jason Lott on 10/12/22.
//
import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var errorL: UILabel!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        submitB(self)
        return self.emailTF.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func submitB(_ sender: Any) {
        let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if (error != nil) {
                let errorMsg = error?.localizedDescription
                self.showError(errorMsg!)
            } else {
                self.errorL.textColor = UIColor.black
                self.showError("Password reset email was sent!")
            }
        }
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

