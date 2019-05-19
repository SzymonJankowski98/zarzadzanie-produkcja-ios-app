//
//  narzedzia.swift
//  aplikacja2
//
//  Created by m2dev on 12.09.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import Foundation
import UIKit

class narzedzia: UIViewController, UITableViewDataSource, UITableViewDelegate, maszynyDelegate
{
    //var id_maszyny = ""
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func fefresh(sender: AnyObject) {
        
        tableView.reloadData()
    }
    var array = [String]()
    var id = [String]()
    var id_m = [String]()
    var id_plytki2 = [String]()
    var id_p = String()
    var id_narzedzia_p = String()
    var nr_gniazda = Int()
    var id_n = String()
    var id_narzedzia_edit = String()
    var id_plytki_edit = String()
    var nazwa = [String]()
    var opis = [String]()
    
    
    func setTableWiev(dane: JSON) {
        array.removeAll()
        id.removeAll()
        id_plytki2.removeAll()
        nazwa.removeAll()
        opis.removeAll()
        if dane.count == 0
        {
            return
        }
        for i in 0...dane.count-1 {
            //array.append(dane[i]["Nr_gniazda"].string!)
            if dane[i]["ID_narzedzia"].string != nil
            {
                id.append(dane[i]["ID_narzedzia"].string!)
            }
            else
            {
                id.append("0")
            }
            if dane[i]["ID_maszyny"].string != nil
            {
                id_m.append(dane[i]["ID_maszyny"].string!)
            }
            else
            {
                id_m.append("0")
            }
            if dane[i]["ID_plytki"].string != nil
            {
                id_plytki2.append(dane[i]["ID_plytki"].string!)
            }
            else
            {
                id_plytki2.append("0")
            }
            if dane[i]["nazwa"].string != nil
            {
                nazwa.append(dane[i]["nazwa"].string!)
            }
            else
            {
                nazwa.append("")
            }
            if dane[i]["opis"].string != nil
            {
                opis.append(dane[i]["opis"].string!)
            }
            else
            {
                opis.append("")
            }
        }
        if maszyny.a == false
        {
            tableView.reloadData()
            maszyny.a = true
        }
    }
    var maszyny = pobierz()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.maszyny.delegate = self
        var adres = "http://localhost/narzedzia.php"
        maszyny.pobierzMaszyny(adres)
        return id.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! cellNarzedzia2
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.nr_gniazda?.text = "\(nazwa[indexPath.row])"
        cell.opis?.text = "Opis: \(opis[indexPath.row])"
        
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
        }
        
        if id_m[indexPath.row] == "0"
        {
            cell.info?.text = "brak płytki"
            cell.nazwa?.text = "narzedzie nie zamontowane"
            cell.info_image.hidden = true
            cell.nazwa_plytki?.hidden = true
            cell.ilosc_ostrzy?.hidden = true
        }
        else if id_plytki2[indexPath.row] == "0"
        {
            let url = NSURL(string: "http://localhost/maszyna.php?id=\(id_m[indexPath.row])")
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                let json = JSON(data: data!)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    cell.nazwa?.text = json[0]["nazwa"].string!
                })
            }
            task.resume()
            
            cell.info?.text = "brak plytki"
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.info_image.hidden = true
            cell.nazwa_plytki?.hidden = true
            cell.ilosc_ostrzy?.hidden = true
        }
        else
        {
            cell.info?.text = ""
            //cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.info?.hidden = true
            
            let url2 = NSURL(string: "http://localhost/maszyna.php?id=\(id_m[indexPath.row])")
            let session2 = NSURLSession.sharedSession()
            let task2 = session2.dataTaskWithURL(url2!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                let json = JSON(data: data!)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    cell.nazwa?.text = json[0]["nazwa"].string!
                })
            }
            task2.resume()
            
            //SELECT plytki.nazwa, COUNT(plytki_ostrza.zuzycie), plytki.Ilosc_ostrzy FROM plytki JOIN plytki_ostrza ON plytki_ostrza.ID_plytki = plytki.ID_plytki JOIN narzedzia ON narzedzia.ID_plytki = plytki.ID_plytki WHERE narzedzia.ID_narzedzia = 1 and plytki_ostrza.zuzycie = 1
            let url = NSURL(string: "http://localhost/plytki_zuzycie.php?id=\(id[indexPath.row])")
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
                            print("ggggg")
                            return
                        }
                        cell.nazwa_plytki?.text = json[0]["nazwa"].string!
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
        }
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if id[indexPath.row] == "0"
        {
            return false
        }
        else if id_plytki2[indexPath.row] == "0"
        {
            return true
        }
        else
        {
            return true
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        print("test")
        let edit = UITableViewRowAction(style: .Normal, title: "edytuj") { action, index in
            self.id_narzedzia_edit = self.id[indexPath.row]
            self.performSegueWithIdentifier("edytujNarzedzia2", sender: self)
        }
        edit.backgroundColor = UIColor(red: 226/255, green: 225/255, blue: 1/255, alpha: 1.0)
        
        return [edit]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        id_p = id_plytki2[indexPath.row]
        id_narzedzia_p = nazwa[indexPath.row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "zamontujNarzedzie"
        {
            if let View = segue.destinationViewController as? zamontujNarzedzie
            {
                View.id_maszyny = id_maszyny
                View.nr_gniazda = nr_gniazda
            }
        }
        if segue.identifier == "zamontujPlytke"
        {
            if let View = segue.destinationViewController as? zamontujPlytke
            {
                print(id_n)
                View.id_narzedzia = id_n
            }
        }
        
        if segue.identifier == "SendDataSegue"
        {
            if let View = segue.destinationViewController as? ViewController4
            {
                //View.id_narzedzia = id_n
                id_plytki = id_p
                nazwa_narzedzia_label = id_narzedzia_p
            }
        }
        if segue.identifier == "edytujNarzedzia2"
        {
            if let View = segue.destinationViewController as? edytujNarzedzia2
            {
                View.id_narzedzia = id_narzedzia_edit
            }
        }
        if segue.identifier == "edytujPlytke"
        {
            if let View = segue.destinationViewController as? edytujPlytke
            {
                View.id_plytki = id_plytki_edit
            }
        }
        
    }
    
    
}
