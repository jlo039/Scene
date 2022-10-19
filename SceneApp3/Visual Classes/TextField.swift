//
//  TextField.swift
//  SceneApp3
//
//  Created by Jason Samuel Lott on 10/19/22.
//

import UIKit
class TextField: UITextField {

    func setup() {
        let border = CALayer()
        border.frame = CGRect(x:0,y:self.frame.height - 2,width:self.frame.width-25,height:2)
        border.backgroundColor = CGColor.init(red: 0.322, green: 0.384, blue: 0.678, alpha: 1)
        self.borderStyle = .none
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
