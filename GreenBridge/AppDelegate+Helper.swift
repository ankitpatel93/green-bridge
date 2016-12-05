//
//  AppDelegate+Helper.swift
//  GreenBridge
//
//  Created by Akki on 03/12/16.
//  Copyright © 2016 Akki. All rights reserved.
//

import UIKit

//MARK: - Colors
let appTintColor                        = UIColor(r: 61, g: 61, b: 61)
let appTintLightColor                   = UIColor(r: 122, g: 122, b: 122)
let appTintDarkColor                    = UIColor(r: 0, g: 0, b: 0)
let appBaseContainerBackgroundColor     = UIColor.white
let appBaseContainerBackgroundColor_1   = UIColor(white: 0.97, alpha: 1)


//MARK: - Typealias
//NSURLSession
typealias URLSessionResponse = (_ responseObject: (NSData?, URLResponse?, NSError?)) -> Void

//Alamofire

let kResponseRootArray              = "kResponseRootArray"

//ApiService Response
typealias ApiServiceResponseJSON = (_ responseStatus : Bool, _ responseJSON: StringAnyObjectDict?) -> Void

//Dictionary
typealias StringStringDict                  = [String: String]
typealias StringAnyObjectDict               = [String: AnyObject]

//MARK: - Constants
let standardLimitForRecordsToFetch = 10

let TEXT_NA                         = "N/A"
let DEFAULT_DATE_FORMAT             = "yyyy-MM-dd"
let DEFAULT_DATE_TIME_FORMAT        = "yyyy-MM-dd HH:mm:ss"
let DEFAULT_DATE_TIME_FORMAT_V7     = "yyyy-MM-dd'T'HH:mm:ss"
let DEFAULT_DATE_TIME_FORMAT_V7_1   = "yyyy-MM-dd'T'HH:mm:ss+ss:ss"
let DEFAULT_TIME_ZONE               = "GMT"


//MARK: - Messages

let MESSAGE_NO_DATA_FOUND_DEFAULT = "No data found!"
let MESSAGE_LOADING_EXTENDED = "Loading..."
let MESSAGE_LOADING            = "Loading"
