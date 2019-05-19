//
//  zamontujNarzedzie.swift
//  aplikacja2
//
//  Created by m2dev on 15.08.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import Foundation
import UIKit

class zamontujNarzedzie: UIViewController, UITableViewDataSource, UITableViewDelegate, maszynyDelegate  {
 
    var id_maszyny = String()
    var nr_gniazda = Int()
    var array = [String]()
    var array_id_narzedzia = [String]()
    var id = [String]()
    var id_plytki2 = [String]()
    var id_p = String()
    var id_n = String()
    var id_narzedzia_edit = String()
    var id_plytki_edit = String()
    var nazwa = [String]()
    var opis = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var back: UIBarButtonItem!
    
    
    
    func setTableWiev(dane: JSON) {
        if dane.count == 0
        {
            return
        }
        for i in 0...dane.count-1 {
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
        maszyny.pobierzMaszyny("http://localhost/narzedzia_wolne.php")
        return nazwa.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Wybierz") as! cellZamontujNarzedzie
        
        cell.button.addTarget(self, action:#selector(zamontuj_n), forControlEvents: .TouchUpInside)
        cell.button?.setTitle("zamontuj", forState: UIControlState.Normal)

        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.nr_gniazda?.text = "\(nazwa[indexPath.row])"
        cell.opis?.text = "Opis: \(opis[indexPath.row])"
        
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
        }
        
        if id_plytki2[indexPath.row] == "0"
        {
            cell.info?.text = "brak plytki"
            cell.button?.tag = indexPath.row
            cell.info_image.hidden = true
            cell.nazwa_plytki?.hidden = true
            cell.ilosc_ostrzy?.hidden = true
        }
        else
        {
            //cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
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
                            cell.info_image?.image = UIImage(named: "yellow")
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
        var zapisz_maszyna = zapisz()
        //let view = self.storyboard?.instantiateInitialViewController() as! ViewController2
        //self.navigationController?.pushViewController(view, animated: true)
        let storyBoard = UIStoryboard(name: "Main",bundle:  nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("VC3")
        let path = "http://localhost/narzedzia_zapisz.php"
        nr_gniazda += 1
        let zapytanie = "a=UPDATE `maszyny_narzedzia` SET `ID_narzedzia` = '\(id[sender.tag])' WHERE `maszyny_narzedzia`.`ID_maszyny` = '\(id_maszyny)' AND `maszyny_narzedzia`.`Nr_gniazda` = '\(nr_gniazda)';"
        print(zapytanie)
        zapisz_maszyna.zapisz(zapytanie, url: path)
        self.presentViewController(vc, animated: true, completion: nil)
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("a")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id_maszyny)
        print(nr_gniazda)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}