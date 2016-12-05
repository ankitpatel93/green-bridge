//
//  CustomNavigationController.swift
//  GreenBridge
//
//  Created by Akki on 03/12/16.
//  Copyright © 2016 Akki. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationBarDelegate, UINavigationControllerDelegate {
    
    let customNavigationBar: CustomNavigationBar = {
        let customNavigationBar = CustomNavigationBar()
        return customNavigationBar
    }()
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupCustomNavigationBar()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupCustomNavigationBar()
    }
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        setupCustomNavigationBar()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCustomNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCustomNavigationBar()
    }
    
    func setupCustomNavigationBar(){
        self.setValue(customNavigationBar, forKeyPath: "navigationBar")
    }
}

