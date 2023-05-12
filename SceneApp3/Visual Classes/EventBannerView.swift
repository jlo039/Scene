//
//  EventBannerView.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 5/12/23.
//

import UIKit

class EventBannerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func setup() {
        
        let border = CALayer()
        border.frame = CGRect(x:0,y:self.frame.height - 2,width:self.frame.width-25,height:2)
        border.backgroundColor = CGColor.init(red: 0.322, green: 0.384, blue: 0.678, alpha: 1)
        self.layer.addSublayer(border)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

}
