//
//  UIVerticallyCenteredTextView.swift
//  GreenBridge
//
//  Created by Akki on 03/12/16.
//  Copyright © 2016 Akki. All rights reserved.
//

import UIKit

class UIVerticallyCenteredTextView: UITextView {
    
    var isMultilineTextView: Bool = false
    
    override var contentSize: CGSize {
        didSet {
            if !isMultilineTextView {
                var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
                topCorrection     = max(0, topCorrection)
                contentInset      = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
            }
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize(){
        isUserInteractionEnabled = false
        isEditable = false
        isSelectable = false
        isScrollEnabled = true
        backgroundColor = UIColor.clear
    }
}

