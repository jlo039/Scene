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
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img1:UIImage = UIImage(imageLiteralResourceName: "img1.jpeg")
        let img2:UIImage = UIImage(imageLiteralResourceName: "img2.jpeg")
        let img3:UIImage = UIImage(imageLiteralResourceName: "img3.jpeg")
        let img4:UIImage = UIImage(imageLiteralResourceName: "img4.jpeg")
        let img5:UIImage = UIImage(imageLiteralResourceName: "img5.png")
        image1.image = img1
        image2.image = img2
        image3.image = img3
        image4.image = img4
        image5.image = img5
        
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
