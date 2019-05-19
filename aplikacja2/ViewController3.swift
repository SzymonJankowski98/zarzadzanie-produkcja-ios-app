//
//  ViewController3.swift
//  aplikacja2
//
//  Created by m2dev on 13.08.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import Foundation
import UIKit

var id_maszyny = ""
var nazwa_maszyny_label = ""

class ViewController3: UIViewController, UITableViewDataSource, UITableViewDelegate, maszynyDelegate
{
    //var id_maszyny = ""
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nazwa_maszyny: UILabel!
    
    @IBAction func fefresh(sender: AnyObject) {
        
        tableView.reloadData()
    }
    var array = [String]()
    var id = [String]()
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
            array.append(dane[i]["Nr_gniazda"].string!)
            if dane[i]["ID_narzedzia"].string != nil
            {
                id.append(dane[i]["ID_narzedzia"].string!)
            }
            else
            {
                id.append("0")
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
        var adres = "http://localhost/gniazda.php?id=\(id_maszyny)"
        maszyny.pobierzMaszyny(adres)
        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! cellNarzedzia
        
        cell.nazwa?.text = "Gniazdo nr \(array[indexPath.row])"
        cell.nr_gniazda?.text = "\(nazwa[indexPath.row])"
        cell.opis?.text = "Opis: \(opis[indexPath.row])"
        
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
        }
        
        if id[indexPath.row] == "0"
        {
            cell.info?.text = "brak narzędzia"
            cell.button?.setTitle("zamontuj narzedzie", forState: UIControlState.Normal)
            cell.button?.tag = indexPath.row
            cell.button.addTarget(self, action:#selector(zamontuj_n), forControlEvents: .TouchUpInside)
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.info_image.hidden = true
            cell.nazwa_plytki?.hidden = true
            cell.opis?.hidden = true
            cell.ilosc_ostrzy?.hidden = true
        }
        else if id_plytki2[indexPath.row] == "0"
        {
            cell.info?.text = "brak plytki"
            cell.button?.setTitle("zamontuj plytkę", forState: UIControlState.Normal)
            cell.button?.tag = indexPath.row
            cell.button.addTarget(self, action:#selector(zamontuj_p), forControlEvents: .TouchUpInside)
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.info_image.hidden = true
            cell.nazwa_plytki?.hidden = true
            cell.ilosc_ostrzy?.hidden = true
        }
        else
        {
            cell.info?.text = ""
            cell.button?.hidden = true
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.info?.hidden = true
            //SELECT plytki.nazwa, COUNT(plytki_ostrza.zuzycie), plytki.Ilosc_ostrzy FROM plytki JOIN plytki_ostrza ON plytki_ostrza.ID_plytki = plytki.ID_plytki JOIN narzedzia ON narzedzia.ID_plytki = plytki.ID_plytki WHERE narzedzia.ID_narzedzia = 1 and plytki_ostrza.zuzycie = 1
            let url = NSURL(string: "http://localhost/plytki_zuzycie.php?id=\(id[indexPath.row])")
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
    
    @IBAction func zamontuj_n (sender: UIButton)
    {
        nr_gniazda = sender.tag
        print("zamontuj narzedzie")
        self.performSegueWithIdentifier("zamontujNarzedzie", sender: self)
    }
    
    @IBAction func zamontuj_p (sender: UIButton)
    {
        id_n = id[sender.tag]
        print("zamontuj plytke")
        self.performSegueWithIdentifier("zamontujPlytke", sender: self)
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
            self.performSegueWithIdentifier("edytujNarzedzie", sender: self)
        }
        let edit_plytka = UITableViewRowAction(style: .Normal, title: "edytuj") { action, index in
            self.id_plytki_edit = self.id_plytki2[indexPath.row]
            self.performSegueWithIdentifier("edytujPlytke", sender: self)
        }
        edit.backgroundColor = UIColor(red: 226/255, green: 225/255, blue: 1/255, alpha: 1.0)
        edit_plytka.backgroundColor = UIColor(red: 226/255, green: 117/255, blue: 1/255, alpha: 1.0)
        if id[indexPath.row] == "0"
        {
            return nil
        }
        else if id_plytki2[indexPath.row] == "0"
        {
            return [edit]
        }
        else
        {
            return [edit, edit_plytka]
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        id_p = id_plytki2[indexPath.row]
        id_narzedzia_p = nazwa[indexPath.row]
        if id[indexPath.row] == "0"
        {
           // self.performSegueWithIdentifier("zamontujNarzedzie", sender: self)
        }
        else if id_plytki2[indexPath.row] == "0"
        {
            
        }
        else
        {
            self.performSegueWithIdentifier("SendDataSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        nazwa_maszyny.text = nazwa_maszyny_label
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
        if segue.identifier == "edytujNarzedzie"
        {
            if let View = segue.destinationViewController as? edytujNarzedzia
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