//
//  ViewController4.swift
//  aplikacja2
//
//  Created by m2dev on 14.08.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import Foundation
import UIKit

var id_plytki = ""
var nazwa_narzedzia_label = ""

class ViewController4: UIViewController, UITableViewDataSource, UITableViewDelegate, maszynyDelegate
{
    //var id_narzedzia = ""
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nazwa: UILabel!
    @IBOutlet weak var opis: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var producent: UILabel!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var dataZamontowania: UILabel!
    
    var array = [String]()
    var id = [String]()
    var zuzycie = [Bool]()
    var ilosc = [String]()

    
    @IBAction func zuzycieAction(sender: AnyObject) {
        var temp = Int()
        if sender.on == true {
            temp = 1
        }
        else
        {
            temp = 0
        }
        var zapisz_maszyna = zapisz()
        let path = "http://localhost/narzedzia_zapisz.php"
        let zapytanie = "a=UPDATE `plytki_ostrza` SET `zuzycie` = '\(temp)' WHERE `plytki_ostrza`.`ID_plytki` = \(id_plytki) AND `plytki_ostrza`.`Nr_ostrza` = \(sender.tag);"
        print(zapytanie)
        zapisz_maszyna.zapisz(zapytanie, url: path)
        
    }
    
    
    @IBAction func ilosc_akcja(sender: UITextField) {
        var zapisz_maszyna = zapisz()
        let path = "http://localhost/narzedzia_zapisz.php"
        let zapytanie = "a=UPDATE `plytki_ostrza` SET `Ilosc_sztuk` = '\(sender.text!)' WHERE `plytki_ostrza`.`ID_plytki` = \(id_plytki) AND `plytki_ostrza`.`Nr_ostrza` = \(sender.tag);"
        print(zapytanie)
        zapisz_maszyna.zapisz(zapytanie, url: path)
    }
    
    @IBAction func stepper_action(sender: UIStepper) {
        guard let cell = sender.superview?.superview?.superview?.superview?.superview as? cellPlytki else
        {
            return
        }
        print("asd")
        cell.ilosc_text.text = String(Int(sender.value))
        print(cell.ilosc_text.text)
        var zapisz_maszyna = zapisz()
        let path = "http://localhost/narzedzia_zapisz.php"
        let zapytanie = "a=UPDATE `plytki_ostrza` SET `Ilosc_sztuk` = '\(cell.ilosc_text.text!)' WHERE `plytki_ostrza`.`ID_plytki` = \(id_plytki) AND `plytki_ostrza`.`Nr_ostrza` = \(sender.tag);"
        print(zapytanie)
        zapisz_maszyna.zapisz(zapytanie, url: path)
    }
    
    func setTableWiev(dane: JSON) {
        
        if dane[0]["nazwa"].string != nil
        {
            nazwa.text! = "\(nazwa_maszyny_label)/\(nazwa_narzedzia_label)"
            navBarTitle.title = dane[0]["nazwa"].string!
        }
        if dane[0]["opis"].string != nil
        {
            opis.text! = "Opis: \(dane[0]["opis"].string!)"
        }
        if dane[0]["Producent"].string != nil
        {
            producent.text! = "Producent: \(dane[0]["Producent"].string!)"
        }
            data.text! = "Data zakupu: \(dane[0]["Data"].string!)"
        if dane[0]["Data_zamontowania"].string != nil
        {
            dataZamontowania.text! = "Data zamontowania: \(dane[0]["Data_zamontowania"].string!)"
        }

        if dane.count == 0
        {
            return
        }
        for i in 0...dane.count-1 {
            array.append(dane[i]["Nr_ostrza"].string!)
            ilosc.append(dane[i]["Ilosc_sztuk"].string!)
            if dane[i]["ID_plytki"].string != nil
            {
                id.append(dane[i]["ID_plytki"].string!)
            }
            else
            {
                id.append("0")
            }
            if dane[i]["zuzycie"].string == "0"
            {
                zuzycie.append(false)
            }
            else
            {
                zuzycie.append(true)
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
        var adres = "http://localhost/plytki.php?id=\(id_plytki)"
        print(adres)
        maszyny.pobierzMaszyny(adres)
        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! cellPlytki
        
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
        }
        
        cell.label?.text = "Ostrze nr \(array[indexPath.row])"
        cell.ilosc_text?.text = ilosc[indexPath.row]
        print(zuzycie[indexPath.row])
        if(zuzycie[indexPath.row] == true)
        {
            cell.switch_zuzycie.on = true
        }
        else
        {
            cell.switch_zuzycie.on = false
        }
        cell.switch_zuzycie.tag = Int(array[indexPath.row])!
        cell.ilosc_text.tag = Int(array[indexPath.row])!
        cell.ilosc_stepper.tag = Int(array[indexPath.row])!
        cell.ilosc_stepper.value = Double(ilosc[indexPath.row])!
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            return false
    }
    
    override func viewDidLoad() {
    }
    
}