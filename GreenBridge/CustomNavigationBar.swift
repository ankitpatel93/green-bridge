//
//  CustomNavigationBar.swift
//  GreenBridge
//
//  Created by Akki on 03/12/16.
//  Copyright © 2016 Akki. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar{
    
    let navigationBarHeight: CGFloat = isUserInterfaceIdiomPhone() ? 44 : 84
    
    lazy var heightIncrease:CGFloat  = self.navigationBarHeight - 44
    
    static let titleLabelFontSize: CGFloat  = isUserInterfaceIdiomPhone() ? 18 : 22
    
    static let titleLabelAttributes : [String: AnyObject] = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: CustomNavigationBar.titleLabelFontSize)]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func initialize(){
        let shift = heightIncrease / 2
        
        // Transform all view to shift upward for [shift] point
        self.transform =
            CGAffineTransform(translationX: 0, y: -shift)
        
        self.titleTextAttributes = CustomNavigationBar.titleLabelAttributes
        self.isTranslucent         = false
        self.barTintColor        = appTintColor
        self.backgroundColor     = UIColor.clear
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let amendedSize:CGSize = super.sizeThatFits(size)
        let newSize: CGSize    = CGSize(width: amendedSize.width, height: navigationBarHeight)
        
        return newSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        let shift = heightIncrease / 2
        
        ///Move the background down for [shift] point
        let classNamesToReposition: [String] = isIOS10AndAbove() ? ["_UIBarBackground"] : ["_UINavigationBarBackground"]
        for view: UIView in self.subviews {
            if classNamesToReposition.contains(NSStringFromClass(type(of: view))) {
                let bounds: CGRect = self.bounds
                var frame: CGRect  = view.frame
                frame.origin.y     = bounds.origin.y + shift - 20.0
                frame.size.height  = bounds.size.height + 20.0
                view.frame         = frame
            }
        }
    }
}
