//
//  CoreViewController.swift
//  GreenBridge
//
//  Created by Akki on 03/12/16.
//  Copyright © 2016 Akki. All rights reserved.
//

import UIKit

class CoreViewController: UIViewController {
    
    let backgroundDefaultImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: IMAGE_LOGIN_BACKGROUND)
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
     
    func setupUI() {
        
    }
}
