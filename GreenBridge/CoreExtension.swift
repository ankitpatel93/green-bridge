//
//  CoreExtension.swift
//  GreenBridge
//
//  Created by Akki on 03/12/16.
//  Copyright © 2016 Akki. All rights reserved.
//

import UIKit

//MARK:- Extensions

//MARK: - UIView
extension UIView{
    func addConstraintsWithFormat(format : String , views : [UIView]){
        var viewsDictionary = [String : UIView]()
        for (index,view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    static func getBaseClearContainerView() -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func pb_takeSnapshot(frame: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext();
        context!.translateBy(x: frame.origin.x * -1, y: frame.origin.y * -1)
        
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        self.layer.render(in: currentContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func constraintsWithFirstItem(firstItemView: UIView) -> [NSLayoutConstraint]{
        
        var relatedConstraints = [NSLayoutConstraint]()
        
        for constraint in self.constraints{
            if let firstItem = constraint.firstItem as? UIView {
                if firstItem == firstItemView{
                    relatedConstraints.append(constraint)
                }
            }
        }
        return relatedConstraints
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
    func showNoDataFoundView(overSubView subView: UIView, withText: String) {
        if let currentNoDataView = self.viewWithTag(CustomNoDataFoundView.CustomNoDataFoundView_TAG) as? CustomNoDataFoundView {
            self.removeConstraints(self.constraintsWithFirstItem(firstItemView: currentNoDataView))
            currentNoDataView.removeFromSuperview()
        }
        
        self.layoutIfNeeded()
        let noDataFoundView = CustomNoDataFoundView(withMessage: withText)
        noDataFoundView.tag = CustomNoDataFoundView.CustomNoDataFoundView_TAG
        noDataFoundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(noDataFoundView)
        
        self.addConstraint(NSLayoutConstraint(item: noDataFoundView, attribute: .centerX, relatedBy: .equal, toItem: subView, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: noDataFoundView, attribute: .centerY, relatedBy: .equal, toItem: subView, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: noDataFoundView, attribute: .width, relatedBy: .equal, toItem: subView, attribute: .width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: noDataFoundView, attribute: .height, relatedBy: .equal, toItem: subView, attribute: .height, multiplier: 1, constant: 0))
        
        self.layoutIfNeeded()
        self.bringSubview(toFront: noDataFoundView)
    }
    
    func removeNoDataFoundView() {
        if let currentNoDataView = self.viewWithTag(CustomNoDataFoundView.CustomNoDataFoundView_TAG) as? CustomNoDataFoundView {
            self.removeConstraints(self.constraintsWithFirstItem(firstItemView: currentNoDataView))
            currentNoDataView.removeFromSuperview()
        }
    }
}



//MARK: - UINavigationController
extension UINavigationController {
    
    func pushViewController(viewController: UIViewController,
                            animated: Bool, completion: @escaping (Void) -> Void) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
}

//MARK: - CALayer
extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x:0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRectMake(0, self.frame.height - thickness, self.frame.width, thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRectMake(0, 0, thickness, self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRectMake(self.frame.width - thickness, 0, thickness, self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
}

//MARK: - UIImage
extension UIImage{
    func getEstimatedSizeOfImageToWidth(estimatedWidth: CGFloat) -> CGSize{
        
        let oldWidth: CGFloat    = self.size.width
        let scaleFactor: CGFloat = estimatedWidth / oldWidth
        let newHeight: CGFloat   = self.size.height * scaleFactor
        let newWidth             = oldWidth * scaleFactor
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        self.draw(in: CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext(
        )
        return newImage!.size
    }
    
    func resizeImage(newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / size.width
        let newHeight = size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        draw(in: CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    func resizeImage(scaleFactor scale: CGFloat) -> UIImage {
        
        let newWidth = size.width * scale
        //let scale = newWidth / image.size.width
        let newHeight = size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        draw(in: CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
    
}

//MARK: - UIColor

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    convenience init(hexString:String) {
        
        let hexString:NSString = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) as NSString
        let scanner = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}


protocol AnyObjectProtocol: AnyObject {}

extension AnyObjectProtocol{
    func toCoreString() -> String{
        if let selfAsBool = self as? Bool{
            return selfAsBool ? "true" : "false"
        } else if let selfAsInt = self as? Int{
            return (selfAsInt == 0) ? "false" : "true"
        } else if let selfAsString = self as? String{
            if selfAsString == "true" || selfAsString == "false"{
                return selfAsString
            }
            if selfAsString == "0" || selfAsString == "1"{
                return (selfAsString == "0") ? "false" : "true"
            }
            
            return selfAsString
        }
        
        return TEXT_NA
    }
}

class CustomAnyObject: AnyObjectProtocol{}

//MARK: - NSObject

extension NSObject {
    
    private typealias `Self` = NSObject
    
    static func isIOS10AndAbove() -> Bool{
        if #available(iOS 10.0, *) {
            return true
        } else {
            return false
        }
    }
    
    
    static func systemFont(withiPhoneSize iPhoneSize: CGFloat, iPadSize: CGFloat) -> UIFont {
        return isUserInterfaceIdiomPhone() ? UIFont.systemFont(ofSize: iPhoneSize) : UIFont.systemFont(ofSize: iPadSize)
    }
    
    func systemFont(withiPhoneSize iPhoneSize: CGFloat, iPadSize: CGFloat) -> UIFont {
        return Self.systemFont(withiPhoneSize: iPhoneSize, iPadSize: iPadSize)
    }
    
    func isIOS10AndAbove() -> Bool{
        return Self.isIOS10AndAbove()
    }
    
    
    static func isUserInterfaceIdiomPhone() -> Bool{
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    func isUserInterfaceIdiomPhone() -> Bool{
        return Self.isUserInterfaceIdiomPhone()
    }
    
    static func isUserInterfaceIdiomPad() -> Bool{
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    func isUserInterfaceIdiomPad() -> Bool{
        return Self.isUserInterfaceIdiomPad()
    }
    
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
       return Self.CGRectMake(x, y, width, height)
    }
    
    static func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
         return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func CGSizeMake(_ width: CGFloat, _ height: CGFloat) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    static func CGSizeMake(_ width: CGFloat, _ height: CGFloat) -> CGSize {
        return Self.CGSizeMake(width, height)
    }
    
    func findEstimatedHeight(ofText text: String, forWidth: CGFloat, font: UIFont, extraPadding: CGFloat = 20, paragraphSpacing: CGFloat? = nil) -> CGFloat{
        let maxFloat: CGFloat = CGFloat(FLT_MAX)
        let size =  CGSize(width: forWidth, height: maxFloat)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        
        var attributes = [String: AnyObject]()
        
        if  paragraphSpacing != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = paragraphSpacing!
            attributes = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle]
        } else {
            attributes = [NSFontAttributeName: font]
        }
        
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: options, attributes: attributes , context:nil)
        
        return estimatedFrame.height + extraPadding
    }
    
    static func getStringFromStringAnyObject(dict:[String: AnyObject]) -> String?{
        do{
            let data = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                return string as String
            }
            
        }catch{
            
        }
        return nil
    }
    
    func getStringFromStringAnyObject(dict:[String: AnyObject]) -> String?{
        return Self.getStringFromStringAnyObject(dict: dict)
    }
    
}

//MARK: - String
extension String  {
    
    var trim: String! {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    
    func toDictionary() -> [String: AnyObject]?{
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    func characterCount(char : Character) -> Int {
        var count = 0
        
        let characters = [Character](self.characters)
        
        for index in 0 ..< characters.count{
            
            if characters[index] == char {
                count += 1
            }
        }
        return count
    }
    
    //Validate Email
    var isEmail: Bool {
        return self.validateEmail(candidate: self)
    }
    
    private func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    //validate PhoneNumber
    var isPhoneNumber: Bool {
        let charcter  = NSCharacterSet(charactersIn: "+0123456789").inverted
        var filtered:NSString!
        let inputString:NSArray = self.components(separatedBy: charcter) as NSArray
        filtered = inputString.componentsJoined(by: "") as NSString!
        return  self == "\(filtered)"
    }
    
    var isValidLengthPhoneNumber: Bool {
        if self.characters.count <= 0 {
            return true
        }
        
        if self.characters.count >= 10 && self.characters.count <= 15 {
            return true
        } else {
            return false
        }
    }
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: NSCharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
}

//MARK: - NSDate
extension NSDate {
    
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.addingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
    
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self as Date).capitalized
        // or use capitalized(with: locale) if you want
    }
}

//MARK: - Array
//MARK: String
protocol _StringType {}
extension String: _StringType {}

