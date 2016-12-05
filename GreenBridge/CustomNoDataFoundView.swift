//
//  CustomNoDataFoundView.swift
//  GreenBridge
//
//  Created by Akki on 03/12/16.
//  Copyright © 2016 Akki. All rights reserved.
//

import UIKit

class CustomNoDataFoundView: UIView {
    
    static let CustomNoDataFoundView_TAG: Int = 1231214124
    
    let noDataFoundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "ic_error_outline_36pt")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = appTintLightColor
        iv.backgroundColor = UIColor.clear
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let noDataFoundLabel: UILabel = {
        let label = UILabel()
        label.textColor = appTintLightColor
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(withMessage text: String) {
        super.init(frame: .zero)
        initialize()
        setupNoDataFoundLabel(withText: text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
        setupNoDataFoundLabel(withText: "No data found!")
    }
    
    let noDataFoundIVWidth: CGFloat = isUserInterfaceIdiomPad() ? 32 : 24
    let noDataFoundLabelHeight: CGFloat = 30
    
    func initialize() {
        backgroundColor = UIColor.clear
        
        addSubview(noDataFoundImageView)
        addSubview(noDataFoundLabel)
        
        //center x
        addConstraint(NSLayoutConstraint(item: noDataFoundImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: noDataFoundLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        //width
        addConstraint(NSLayoutConstraint(item: noDataFoundImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: noDataFoundIVWidth))
        addConstraint(NSLayoutConstraint(item: noDataFoundLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0))
        
        //height
        addConstraint(NSLayoutConstraint(item: noDataFoundImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: noDataFoundIVWidth))
        addConstraint(NSLayoutConstraint(item: noDataFoundLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: noDataFoundLabelHeight))
        
        //center y // Top
        addConstraint(NSLayoutConstraint(item: noDataFoundImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: -noDataFoundIVWidth))
        addConstraint(NSLayoutConstraint(item: noDataFoundLabel, attribute: .top, relatedBy: .equal, toItem: noDataFoundImageView, attribute: .bottom, multiplier: 1, constant: 8))
    }
    
    func setupNoDataFoundLabel(withText text: String) {
        noDataFoundLabel.text = text
    }
}

