//
//  CheckBoxButton.swift
//  GreenBridge
//
//  Created by Akki on 03/12/16.
//  Copyright © 2016 Akki. All rights reserved.
//

import UIKit

protocol CheckBoxButtonDelegate {
    func checkBoxButton(didChangeCheckStatus checkBoxButton: CheckBoxButton)
}

class CheckBoxButton: UIButton{
    // Images
    let checkedImage   = (UIImage(named: "ic_check_box_white")! as UIImage).withRenderingMode(.alwaysTemplate)
    let uncheckedImage = (UIImage(named: "ic_check_box_outline_blank_white")! as UIImage).withRenderingMode(.alwaysTemplate)
    
    var delegate: CheckBoxButtonDelegate?
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.addTarget(self, action: #selector(CheckBoxButton.buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
    }
    
    func buttonClicked(sender: CheckBoxButton) {
        if sender == self {
            isChecked = !isChecked
            delegate?.checkBoxButton(didChangeCheckStatus: sender)
        }
    }
}

