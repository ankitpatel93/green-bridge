//
//  CustomProgressView.swift
//  GreenBridge
//
//  Created by Akki on 03/12/16.
//  Copyright © 2016 Akki. All rights reserved.
//

import UIKit

class CustomProgressView: UIView{
    
    let backgroundTransparentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.alpha = 0
        return view
    }()
    
    let bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.2, alpha: 1)
        return view
    }()
    
    var isProgressing: Bool = false
    
    private var progressMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private var progressView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.activityIndicatorViewStyle = .whiteLarge
        view.tintColor = UIColor.white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    var bottomContainerHeight: CGFloat{
        get{
            return 64
        }
    }
    
    var bottomContainerTopConstraint: NSLayoutConstraint?
    
    private func initialize() {
        isProgressing = false
        backgroundTransparentView.alpha = 0
    }
    
    func setupBottomContainerView(messageText: String) {
        bottomContainerView.addSubview(progressView)
        bottomContainerView.addSubview(progressMessageLabel)
        
        bottomContainerView.addConstraintsWithFormat(format: "H:|-16-[v0(\(bottomContainerHeight * 0.8))]-8-[v1]-16-|", views: [progressView, progressMessageLabel])
        bottomContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: [progressMessageLabel])
        bottomContainerView.addConstraintsWithFormat(format: "V:[v0(\(bottomContainerHeight * 0.8))]", views: [progressView])
        bottomContainerView.addConstraint(NSLayoutConstraint(item: progressView, attribute: .centerY, relatedBy: .equal, toItem: bottomContainerView, attribute: .centerY, multiplier: 1, constant: 0))
        progressMessageLabel.text = messageText
    }
    
    func updateProgressMessage(withMessage newMessage: String) {
        progressMessageLabel.text = newMessage
    }
    
    func showProgressView(withMessage message: String =  MESSAGE_LOADING_EXTENDED) {
        if !isProgressing {
            if let appWindow = UIApplication.shared.keyWindow{
                
                backgroundTransparentView.removeFromSuperview()
                bottomContainerView.removeFromSuperview()
                
                appWindow.removeConstraints(appWindow.constraintsWithFirstItem(firstItemView: backgroundTransparentView))
                appWindow.removeConstraints(appWindow.constraintsWithFirstItem(firstItemView: bottomContainerView))
                
                appWindow.addSubview(backgroundTransparentView)
                appWindow.addSubview(bottomContainerView)
                
                appWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: [backgroundTransparentView])
                appWindow.addConstraintsWithFormat(format: "V:|[v0]|", views: [backgroundTransparentView])
                
                bottomContainerTopConstraint = NSLayoutConstraint(item: bottomContainerView, attribute: .top, relatedBy: .equal, toItem: appWindow, attribute: .bottom, multiplier: 1, constant: 0)
                appWindow.addConstraintsWithFormat(format: "H:|[v0]|", views: [bottomContainerView])
                appWindow.addConstraintsWithFormat(format: "V:[v0(\(bottomContainerHeight))]", views: [bottomContainerView])
                appWindow.addConstraint(bottomContainerTopConstraint!)
                setupBottomContainerView(messageText: message)
                
                backgroundTransparentView.alpha = 0
                appWindow.layoutIfNeeded()
                
                bottomContainerTopConstraint?.constant = -bottomContainerHeight
                UIView.animate(withDuration: 0.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.progressView.startAnimating()
                    self.backgroundTransparentView.alpha = 1
                    appWindow.layoutIfNeeded()
                    
                }, completion: { (completed: Bool) in
                    self.isProgressing = true
                })
            }
        }
    }
    
    func hideProgressView() {
        if bottomContainerTopConstraint?.constant != 0 {
            if let appWindow = UIApplication.shared.keyWindow{
                bottomContainerTopConstraint?.constant = 0
                
                UIView.animate(withDuration: 0.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    
                    self.backgroundTransparentView.alpha = 0
                    appWindow.layoutIfNeeded()
                    
                }, completion: { (completed: Bool) in
                    self.progressView.stopAnimating()
                    self.isProgressing = false
                    appWindow.removeConstraints(appWindow.constraintsWithFirstItem(firstItemView: self.backgroundTransparentView))
                    appWindow.removeConstraints(appWindow.constraintsWithFirstItem(firstItemView: self.bottomContainerView))
                    if self.bottomContainerTopConstraint != nil{
                        appWindow.removeConstraint(self.bottomContainerTopConstraint!)
                    }
                    self.backgroundTransparentView.removeFromSuperview()
                    self.bottomContainerView.removeFromSuperview()
                })
            }
        }
    }
}
