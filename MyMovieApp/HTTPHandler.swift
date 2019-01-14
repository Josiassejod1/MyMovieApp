//
//  HTTPHandler.swift
//  MyMovieApp
//
//  Created by Dalvin Sejour on 1/11/19.
//  Copyright © 2019 Dalvin Sejour. All rights reserved.
//

import Foundation

class HTTPHandler {
    static func getJson(urlString: String, completionHandler: @escaping (Data?) ->  (Void)) {
        let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url =  URL(string: urlString!)
        
        print("URL: being used \(url!)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if let data = data {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                print("request completed with \(statusCode)")
                if (statusCode == 200) {
                    print("return with completed handler")
                    completionHandler(data as Data)
                }
            } else if let error = error {
                print("***** There was an error with the HTTP response ****")
                print(error)
                completionHandler(nil)
            }
        }
        task.resume()
    }
}
