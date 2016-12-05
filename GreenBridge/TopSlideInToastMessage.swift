//
//  TopSlideInToastMessage.swift
//  GreenBridge
//
//  Created by Akki on 03/12/16.
//  Copyright © 2016 Akki. All rights reserved.
//

import UIKit

let slideInLabelTag: Int = 14154551

typealias TopSlideInToastMessageCompletionHandler = (_ completed: Bool) -> Void

class TopSlideInToastMessage : NSObject {
     
    static func showToast(withText text: String, duration: Double = 1, completionHandler: TopSlideInToastMessageCompletionHandler? = nil){
        if let window = (UIApplication.shared.delegate as! AppDelegate).window {
            
            window.viewWithTag(slideInLabelTag)?.removeFromSuperview()
            
            let topPadding: CGFloat      = 44
            let leftRightMargin: CGFloat = 16
            let labelPadding: CGFloat    = 24
            
            let labelFontSize: CGFloat   = isUserInterfaceIdiomPad() ? 17 : 15
            
            let toastLabel: UILabel = {
                let label                 = UILabel()
                label.textColor           = UIColor.white
                label.backgroundColor     = UIColor(white: 0.1, alpha: 1)
                label.layer.cornerRadius  = 4
                label.layer.masksToBounds = true
                label.font                = UIFont.systemFont(ofSize: labelFontSize)
                label.textAlignment       = .center
                label.text                = text
                label.numberOfLines       = 0
                label.tag                 = slideInLabelTag
                return label
            }()
            
            let rect = NSString(string: text).boundingRect(with: CGSize(width: window.frame.width - (leftRightMargin * 2), height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: labelFontSize)], context: nil)
            
            var labelSize = rect.size
            
            
            labelSize.width  = labelSize.width + labelPadding
            labelSize.height = labelSize.height + labelPadding
            
            let x: CGFloat = (window.frame.width - labelSize.width) / 2
            
            toastLabel.frame = CGRectMake(x , 0 - labelSize.height, labelSize.width, labelSize.height)
            window.addSubview(toastLabel)
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                toastLabel.frame = CGRectMake(x, topPadding , labelSize.width, labelSize.height)
                
            }, completion: { (completed) in
                UIView.animate(withDuration: 0.25, delay: duration, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
                    toastLabel.frame = CGRectMake(x, 0 - labelSize.height, labelSize.width, labelSize.height)
                    
                }, completion: { (completed) in
                    toastLabel.removeFromSuperview()
                    
                    if completionHandler != nil{
                        completionHandler!(true)
                    }
                })
            })
        }
    }
}

