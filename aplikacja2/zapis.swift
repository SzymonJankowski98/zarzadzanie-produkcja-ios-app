//
//  zapis.swift
//  aplikacja2
//
//  Created by m2dev on 08.08.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import Foundation

class zapisz {
    func zapisz(zapytanie: String, url: String)  {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.HTTPBody = zapytanie.dataUsingEncoding(NSUTF8StringEncoding)
        print(request)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print(error)
                return
            }
            print(response)
            
            let responseString=NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(responseString)
            print(data)
        }
        task.resume()
    }
}