//
//  maszyny.swift
//  aplikacja2
//
//  Created by m2dev on 17.07.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import Foundation

struct Maszyny {
    let id: Int
    let nazwa: String
    let opis: String
    
    init(id: Int, nazwa: String, opis: String)
    {
        self.id = id
        self.nazwa = nazwa
        self.opis = opis
    }
}

protocol maszynyDelegate {
    func setTableWiev(dane: JSON)
}

class MaszynyDB {
    
    var delegate: maszynyDelegate?
    var a = false
    
    func pobierzMaszyny()
    {
        let path = "http://localhost/maszyny.php"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            //print(">>>>>\(data)")
            let json = JSON(data: data!)
            //print(">>>>>\(json)")
            //let nazwa = json[0]["nazwa"].string
            //let nazwa2 = json[1]["nazwa"].string
            //print(nazwa)
            if self.delegate != nil{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    self.delegate?.setTableWiev(json)
                })
            }
            
        }
        task.resume()
        
    }
}