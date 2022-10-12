//
//  ForgotPassord.swift
//  SceneApp3
//
//  Created by Jason Samuel Lott on 10/5/22.
//

import UIKit
import FirebaseAuth

class ForgotPassword: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var errorL: UILabel!
    

    @IBAction func submitB(_ sender: Any) {
        let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if (error != nil) {
                let errorMsg = error?.localizedDescription
                self.showError(errorMsg!)
            }
        }
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
