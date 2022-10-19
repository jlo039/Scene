//
//  Button.swift
//  SceneApp3
//
//  Created by Jason Samuel Lott on 10/19/22.
//

import UIKit
class Button: UIButton {
    func setup() {
        self.backgroundColor = UIColor.init(red: 0.322, green: 0.384, blue: 0.678, alpha: 1)
        self.layer.cornerRadius = 17
        self.tintColor = UIColor.init(red: 0.851, green: 0.855, blue: 0.918, alpha: 1)
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
