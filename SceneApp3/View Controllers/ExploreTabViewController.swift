//
//  ExploreTabViewController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 12/1/22.
//

import UIKit

class ExploreTabViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image1:UIImage = UIImage(imageLiteralResourceName: "img-1")
        let image2:UIImage = UIImage(imageLiteralResourceName: "img-2")
        let image3:UIImage = UIImage(imageLiteralResourceName: "img-3")
        let image4:UIImage = UIImage(imageLiteralResourceName: "img-4")
        let image5:UIImage = UIImage(imageLiteralResourceName: "img-5")
        let image6:UIImage = UIImage(imageLiteralResourceName: "img-6")
        let image7:UIImage = UIImage(imageLiteralResourceName: "img-7")
        let image8:UIImage = UIImage(imageLiteralResourceName: "img-8")
        
        imageView1.image = image1
        imageView2.image = image2
        imageView3.image = image3
        imageView4.image = image4
        imageView5.image = image5
        imageView6.image = image6
        imageView7.image = image7
        imageView8.image = image8
        
        
        
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
