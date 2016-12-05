//
//  NoBorderTextField.swift
//  GreenBridge
//
//  Created by Akki on 04/12/16.
//  Copyright © 2016 Akki. All rights reserved.
//

import UIKit

class NoBorderTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init(tintColor: UIColor = .white, textColor: UIColor = .white) {
        super.init(frame: .zero)
        commonInit()
    }
    
    func commonInit() {
        self.borderStyle = .none
        self.backgroundColor = .clear
    }
}
