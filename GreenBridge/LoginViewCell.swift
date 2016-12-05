//
//  LoginViewCell.swift
//  GreenBridge
//
//  Created by Akki on 04/12/16.
//  Copyright © 2016 Akki. All rights reserved.
//

import UIKit

class LoginViewCell: BaseTableViewCell, CheckBoxButtonDelegate {
    
    
    let textFieldFont = systemFont(withiPhoneSize: 14, iPadSize: 17)
    
    lazy var usernameTextField: NoBorderTextField = {
        let tf = NoBorderTextField()
        tf.font = self.textFieldFont
        return tf
    }()
    
    lazy var passwordTextField: NoBorderTextField = {
        let tf = NoBorderTextField()
        tf.font = self.textFieldFont
        return tf
    }()
    
    lazy var rememberMeButon: CheckBoxButton = {
        let btn = CheckBoxButton()
        btn.delegate = self
        btn.setTitle("Remember Me", for: .normal)
        btn.titleLabel?.font =  systemFont(withiPhoneSize: 18, iPadSize: 21)
        btn.tintColor = .white
        return btn
    }()
    
    
    override func setupViews() {
        super.setupViews()
    }
    
    
    
    //MARK: - CheckBoxButton Delegate
    func checkBoxButton(didChangeCheckStatus checkBoxButton: CheckBoxButton) {
        
    }
}
