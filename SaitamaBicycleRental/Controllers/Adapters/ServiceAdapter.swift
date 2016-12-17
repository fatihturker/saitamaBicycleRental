//
//  File.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 26/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import Foundation
extension Controllers.Adapters{
    /** Adapter for service requests */
    class ServiceAdapter{
        var reachability: Controllers.Utility.Reachability = Controllers.Utility.Reachability()
        func makePostRequest(observer: String, serviceUrl: String, with: Data){
            let headers:[[String: String]]! = nil
            makeRequest(argServiceUrl: serviceUrl, with: with, headers: headers, observer: observer, httpMethod: "POST")
        }
        
        func makeRequestWithToken(observer: String, serviceUrl: String, with: Data!, httpMethod: String){
            let tokenProvider: Controllers.Providers.TokenProvider = Controllers.Providers.TokenProvider()
            var headers:[[String: String]] = []
            headers.append(["fieldName": "Authorization", "value": tokenProvider.getToken()])
            makeRequest(argServiceUrl: serviceUrl, with: with, headers: headers, observer: observer, httpMethod: httpMethod)
        }
        
        private func makeRequest(argServiceUrl: String, with: Data!, headers: [[String: String]]!, observer: String, httpMethod: String){
            var userInfo: [String: Any]? = nil
            if !reachability.isInternetAvailable(){
                let errorData = try? JSONSerialization.data(withJSONObject: ["message": "Please check your internet connection"], options: .prettyPrinted)
                userInfo = ["error": errorData!]
                NotificationCenter.default.post(name: Notification.Name(observer), object: nil, userInfo: userInfo)
                return
            }
            
            var request = URLRequest(url: URL(string: argServiceUrl)!)
            request.httpMethod = httpMethod
            request.httpBody = with
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            if headers != nil{
                for header: [String: String] in headers{
                    request.addValue(header["value"]!, forHTTPHeaderField: header["fieldName"]!)
                }
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    let errorData = try? JSONSerialization.data(withJSONObject: ["message": error?.localizedDescription], options: .prettyPrinted)
                    userInfo = ["error": errorData!]
                    NotificationCenter.default.post(name: Notification.Name(observer), object: nil, userInfo: userInfo)
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    userInfo = ["error": data]
                }else{
                    userInfo = ["data": data]
                }
                
                NotificationCenter.default.post(name: Notification.Name(observer), object: nil, userInfo: userInfo)
            }
            task.resume()
        }
    }
}
