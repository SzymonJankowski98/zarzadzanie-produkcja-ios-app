//
//  plytki.swift
//  aplikacja2
//
//  Created by m2dev on 13.09.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import Foundation
import UIKit

class Plytki: UIViewController, UITableViewDataSource, UITableViewDelegate, maszynyDelegate  {
    
    var id_narzedzia = String()
    var id_p = ""
    var array = [String]()
    var array_id_narzedzia = [String]()
    var opis = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var back: UIBarButtonItem!
    
    
    @IBAction func refresh(sender: AnyObject) {
        tableView.reloadData()
    }
    
    func setTableWiev(dane: JSON) {
        array.removeAll()
        array_id_narzedzia.removeAll()
        opis.removeAll()
        if dane.count == 0
        {
            print(dane)
            return
        }
        else
        {
            for i in 0...dane.count-1 {
                array.append(dane[i]["nazwa"].string!)
                array_id_narzedzia.append(dane[i]["ID_plytki"].string!)
                opis.append(dane[i]["opis"].string!)
                print(dane[i]["nazwa"].string!)
            }
            if maszyny.a == false
            {
                tableView.reloadData()
                maszyny.a = true
            }
        }
    }
    var maszyny = pobierz()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.maszyny.delegate = self
        maszyny.pobierzMaszyny("http://localhost/plytki2.php")
        print("asdasd")
        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("wybierz") as! cellPlytka
        cell.nazwa?.text = array[indexPath.row]
        cell.opis?.text = opis[indexPath.row]
        
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
        }
        
        
        let url = NSURL(string: "http://localhost/plytki_zuzycie2.php?id=\(array_id_narzedzia[indexPath.row])")
        print(url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            let json = JSON(data: data!)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if json[0]["Ilosc_ostrzy"] != "0"
                {
                    cell.info_image?.image = UIImage(named: "red")
                    if json[0]["nazwa"].string == nil
                    {
                        return
                    }
                    cell.ilosc_ostrzy?.text = "\(String(Int(json[0]["Ilosc_ostrzy"].string!)! - Int(json[0]["COUNT(plytki_ostrza.zuzycie)"].string!)!))/\(json[0]["Ilosc_ostrzy"].string!)"
                    var a = Int(json[0]["Ilosc_ostrzy"].string! )! - Int(json[0]["COUNT(plytki_ostrza.zuzycie)"].string!)!
                    if (a > 1)
                    {
                        cell.info_image?.image = UIImage(named: "green")
                    }
                    if (a == 1)
                    {
                        if json[0]["Ilosc_ostrzy"].string! == "1"
                            {
                                cell.info_image?.image = UIImage(named: "green")
                        }
                        else
                        {
                            cell.info_image?.image = UIImage(named: "yellow")
                        }

                    }
                    if (a < 1)
                    {
                        cell.info_image?.image = UIImage(named: "red")
                    }
                }
            })
        }
        task.resume()
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(array_id_narzedzia[indexPath.row])
        id_p = array_id_narzedzia[indexPath.row]
        self.performSegueWithIdentifier("szczegoly", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "szczegoly"
        {
            if let View = segue.destinationViewController as? plytkiSzczegoly
            {
                //View.id_narzedzia = id_n
                id_plytki2 = id_p
            }
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

