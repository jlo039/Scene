//
//  ExploreTabViewController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 11/18/22.
//

import UIKit

class ExploreTabViewController: UIViewController {

    @IBOutlet weak var chooseDate: UIDatePicker!
    @IBOutlet weak var searchStack: UIStackView!
    @IBOutlet weak var eventStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let eventStackConstraint = NSLayoutConstraint(item: eventStack!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: eventStack.superview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 0.9, constant: 0)
        //searchStack.addConstraint(eventStackConstraint)
        
        // Do any additional setup after loading the view.
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
