//
//  zamontujPlytke.swift
//  aplikacja2
//
//  Created by m2dev on 17.08.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import Foundation
import UIKit

class zamontujPlytke: UIViewController, UITableViewDataSource, UITableViewDelegate, maszynyDelegate  {
    
    var id_narzedzia = String()
    var array = [String]()
    var array_id_narzedzia = [String]()
    var opis = [String]()
    var id_p = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var back: UIBarButtonItem!
    
    
    
    func setTableWiev(dane: JSON) {
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
        maszyny.pobierzMaszyny("http://localhost/plytki_wolne.php")
        print("asdasd")
        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("wybierz") as! cellZamontujPlytke
        cell.nazwa?.text = array[indexPath.row]
        cell.opis?.text = opis[indexPath.row]
        
        cell.button.tag = indexPath.row
        
        cell.button.addTarget(self, action:#selector(zamontuj_n), forControlEvents: .TouchUpInside)
        
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
        }
            
        
        let url = NSURL(string: "http://localhost/plytki_zuzycie2.php?id=\(array_id_narzedzia[indexPath.row])")
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
    
    @IBAction func zamontuj_n (sender: UIButton)
    {
        var zapisz_maszyna = zapisz()
        //let view = self.storyboard?.instantiateInitialViewController() as! ViewController2
        //self.navigationController?.pushViewController(view, animated: true)
        let storyBoard = UIStoryboard(name: "Main",bundle:  nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("VC3")
        let path = "http://localhost/narzedzia_zapisz.php"
        
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = "YYYY-MM-dd"
        let dzisiaj = dateFormater.stringFromDate(NSDate())

        let zapytanie = "a=UPDATE `narzedzia` SET `ID_plytki` = '\(array_id_narzedzia[sender.tag])' WHERE `narzedzia`.`ID_narzedzia` = \(id_narzedzia);"
        let zapytanie2 = "a=UPDATE `plytki` SET `Data_zamontowania` = '\(dzisiaj)' WHERE `plytki`.`ID_plytki` = \(array_id_narzedzia[sender.tag]);"
        print(zapytanie2)
        zapisz_maszyna.zapisz(zapytanie, url: path)
        zapisz_maszyna.zapisz(zapytanie2, url: path)
        self.presentViewController(vc, animated: true, completion: nil)
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(array_id_narzedzia[indexPath.row])
        id_p = array_id_narzedzia[indexPath.row]
        self.performSegueWithIdentifier("szczegoly2", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "szczegoly2"
        {
            if let View = segue.destinationViewController as? plytkiSzczegoly2
            {
                //View.id_narzedzia = id_n
                id_plytki3 = id_p
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
