//
//  ApiService+Helper.swift
//  GreenBridge
//
//  Created by Akki on 03/12/16.
//  Copyright © 2016 Akki. All rights reserved.
//

import UIKit

let boundary = "---------------------------SOMERANDOMBOUNDARY1234567890"

let REQUEST_TIME_OUT_DURATION: TimeInterval = 60 // IN SECONDS

extension ApiService{
    func getMultipartData(forname name:String, value: AnyObject) -> NSMutableData{
        let data = NSMutableData()
        data.append("--\(boundary)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        data.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        data.append("\(value)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        return data
    }
    
    func getEndingFormData() -> NSMutableData{
        let data = NSMutableData()
        return data
    }
    
    func modifyRequestWithContentType( request: inout NSMutableURLRequest){
//        if isCurrentVersion7() {
//            //V7 request should contain oauth-token AKA session_id in header
//            if let auth_token = CPUserDefaults.sharedCPUserDefaults.auth_token {
//                request.addValue(auth_token, forHTTPHeaderField: "oauth-token")
//            }
//        } else {
//            //V6 Requests
//            //replace current header with custom header
//            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//            //append header
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//        }
    }
    
    func startNetworkActivityIndicator() {
        //        if !UIApplication.sharedApplication().networkActivityIndicatorVisible {
        //            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        //        }
    }
    
    func stopNetworkActivityIndicator() {
        //        if UIApplication.sharedApplication().networkActivityIndicatorVisible {
        //            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        //        }
    }
    
    func getResponseJson(withMethodRawValue rawValue: String, requestUrl: String, dataToSend: NSMutableData, parameters: StringAnyObjectDict = [:], senderVC: CoreViewController, completion: ApiServiceResponseJSON) {
        
        var request = NSMutableURLRequest(url: NSURL(string:requestUrl)! as URL,cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: REQUEST_TIME_OUT_DURATION)
        request.httpMethod = rawValue
        request.httpBody = dataToSend as Data
        
        modifyRequestWithContentType(request: &request)
        
        printRequest(req: request)
        
        startNetworkActivityIndicator()
        
        
        let urlSession = URLSession(configuration: .default)
        
        urlSession.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            
        }.resume()
        
//        Alamofire.request(request).responseJSON { (response) in
//            self.stopNetworkActivityIndicator()
//            if response.result.error != nil {
//                TopSlideInToastMessage.showToast(withKey: KEY_API_RESPONSE_ERROR)
//                print(response.result.error?.localizedDescription)
//                completion(responseStatus: false, responseJSON: nil)
//                return
//            }
//            
//            if let JSONDict = response.result.value as? StringAnyObjectDict{
//                if self.handleFailure(withJSON: JSONDict, senderVC: senderVC) {
//                    completion(responseStatus: true, responseJSON: JSONDict)
//                } else {
//                    completion(responseStatus: false, responseJSON: nil)
//                }
//                return
//            } else if let JSONArray = response.result.value as? [AnyObject]{
//                completion(responseStatus: true, responseJSON: [kResponseRootArray: JSONArray])
//                return
//            } else {
//                TopSlideInToastMessage.showToast(withKey: KEY_API_RESPONSE_ERROR)
//                completion(responseStatus: false, responseJSON: nil)
//                return
//            }
//        }
    }
    
//    func getResponseJson_GET(requestUrl: String, parameters: StringAnyObjectDict, encoding: ParameterEncoding = .JSON, senderVC: CoreViewController, completion: ApiServiceResponseJSON) {
//        
//        var request = NSMutableURLRequest(URL: NSURL(string:requestUrl)!,cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: REQUEST_TIME_OUT_DURATION)
//        modifyRequestWithContentType(&request)
//        
//        printRequestGET(request, params: parameters)
//        
//        self.startNetworkActivityIndicator()
//        Alamofire.request(.GET, request, parameters: parameters).responseJSON { (response) in
//            self.stopNetworkActivityIndicator()
//            if response.result.error != nil {
//                TopSlideInToastMessage.showToast(withKey: KEY_API_RESPONSE_ERROR)
//                print(response.result.error?.localizedDescription)
//                completion(responseStatus: false, responseJSON: nil)
//                return
//            }
//            
//            if let JSONDict = response.result.value as? StringAnyObjectDict {
//                if self.handleFailure(withJSON: JSONDict, senderVC: senderVC) {
//                    completion(responseStatus: true, responseJSON: JSONDict)
//                } else {
//                    completion(responseStatus: false, responseJSON: nil)
//                }
//                return
//            }
//            if let JSONArray = response.result.value as? [AnyObject]{
//                completion(responseStatus: true, responseJSON: [kResponseRootArray: JSONArray])
//                return
//            }
//            
//            TopSlideInToastMessage.showToast(withKey: KEY_API_RESPONSE_ERROR)
//            completion(responseStatus: false, responseJSON: nil)
//            return
//        }
//    }
//    
//    func getResponseJson_PUT(requestUrl: String, parameters: StringAnyObjectDict, encoding: ParameterEncoding = .JSON, senderVC: CoreViewController, completion: ApiServiceResponseJSON) {
//        
//        var request = NSMutableURLRequest(URL: NSURL(string:requestUrl)!,cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: REQUEST_TIME_OUT_DURATION)
//        modifyRequestWithContentType(&request)
//        printRequestGET(request, params: parameters)
//        
//        self.startNetworkActivityIndicator()
//        Alamofire.request(.PUT, request, parameters: parameters, encoding: encoding).responseJSON { (response) in
//            self.stopNetworkActivityIndicator()
//            if response.result.error != nil{
//                
//                TopSlideInToastMessage.showToast(withKey: KEY_API_RESPONSE_ERROR)
//                print(response.result.error?.localizedDescription)
//                completion(responseStatus: false, responseJSON: nil)
//                return
//            }
//            
//            if let JSONDict = response.result.value as? StringAnyObjectDict {
//                if self.handleFailure(withJSON: JSONDict, senderVC: senderVC) {
//                    completion(responseStatus: true, responseJSON: JSONDict)
//                } else {
//                    completion(responseStatus: false, responseJSON: nil)
//                }
//                return
//            } else if let JSONArray = response.result.value as? [AnyObject] {
//                completion(responseStatus: true, responseJSON: [kResponseRootArray: JSONArray])
//                return
//            } else {
//                TopSlideInToastMessage.showToast(withKey: KEY_API_RESPONSE_ERROR)
//                completion(responseStatus: false, responseJSON: nil)
//                return
//            }
//        }
//    }
    
    func handleFailure(withJSON JSONDict: StringAnyObjectDict, senderVC: CoreViewController) -> Bool {
        let isSuccess = true
        
        
        return isSuccess
    }
    
    func printRequest(req: NSMutableURLRequest){
        print("=============================================================================")
        print(req.url?.absoluteString ?? "nil")
        print(NSString(data: req.httpBody!, encoding: String.Encoding.utf8.rawValue)!)
        print("=============================================================================")
    }
    
    func printRequestGET(req: NSMutableURLRequest, params: StringAnyObjectDict){
        print("=============================================================================")
        print(req.url?.absoluteString ?? "nil")
        print(params)
        print("=============================================================================")
    }
}


