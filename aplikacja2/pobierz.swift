//
//  pobierz.swift
//  aplikacja2
//
//  Created by m2dev on 13.08.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import Foundation

class pobierz {
    
    
    var delegate: maszynyDelegate?
    var a = false
    
    func pobierzMaszyny (path: String)
    {
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            let json = JSON(data: data!)
            print(self.delegate)
            if self.delegate != nil{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.setTableWiev(json)
                })
            }
            
        }
        task.resume()
        
    }
}