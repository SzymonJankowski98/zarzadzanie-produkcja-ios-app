//
//  edytujPlytke.swift
//  aplikacja2
//
//  Created by m2dev on 20.08.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import UIKit

class edytujPlytke: UIViewController, maszynyDelegate {
    
    var id_plytki = String()
    
    var maszyny = pobierz()
    
    func setTableWiev(dane: JSON) {
        if(dane[0]["nazwa"].string != nil)
        {
            name.text = dane[0]["nazwa"].string!
        }
        if(dane[0]["opis"].string != nil)
        {
            opis.text = dane[0]["opis"].string!
        }
        if(dane[0]["Producent"].string != nil)
        {
            producent.text = dane[0]["Producent"].string!
        }
        if (dane[0]["Data"].string != nil) {
            var data_edytuj = NSDateFormatter()
            data_edytuj.dateFormat = "YYYY-MM-dd"
            let datea: NSDate? = data_edytuj.dateFromString("\(dane[0]["Data"].string!)")
            dataPicker.date = datea!
            
        }
    }
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var opis: UITextField!
    @IBOutlet weak var producent: UITextField!
    @IBOutlet weak var dataPicker: UIDatePicker!
    
    @IBAction func zaktualizuj(sender: AnyObject) {
        var zapisz_maszyna = zapisz()
        //let view = self.storyboard?.instantiateInitialViewController() as! ViewController2
        //self.navigationController?.pushViewController(view, animated: true)
        let storyBoard = UIStoryboard(name: "Main",bundle:  nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("VC3")
        let path = "http://localhost/narzedzia_zapisz.php"
        let zapytanie = "a=UPDATE `plytki` SET `nazwa` = '\(name.text!)', `opis` = '\(opis.text!)', `Producent` = '\(producent.text!)', `Data` = '\(String(String(dataPicker.date).characters.prefix(10)))' WHERE `plytki`.`ID_plytki` = \(id_plytki);"
        print(zapytanie)
        zapisz_maszyna.zapisz(zapytanie, url: path)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func wymontuj(sender: AnyObject) {
        var zapisz_maszyna = zapisz()
        //let view = self.storyboard?.instantiateInitialViewController() as! ViewController2
        //self.navigationController?.pushViewController(view, animated: true)
        let storyBoard = UIStoryboard(name: "Main",bundle:  nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("VC3")
        let path = "http://localhost/narzedzia_zapisz.php"
        let zapytanie = "a=UPDATE `narzedzia` SET `ID_plytki` = NULL WHERE `narzedzia`.`ID_plytki`= \(id_plytki);"
        zapisz_maszyna.zapisz(zapytanie, url: path)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func usun(sender: AnyObject) {
        let alert = UIAlertController(title: "Usuń", message: "Czy chcesz usunąć płytkę?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in
                
                var zapisz_maszyna = zapisz()
                let path = "http://localhost/narzedzia_zapisz.php"
                let zapytanie = "a=DELETE FROM `plytki_ostrza` WHERE `plytki_ostrza`.`ID_plytki`= \(self.id_plytki);"
                zapisz_maszyna.zapisz(zapytanie, url: path)
                
                let path3 = "http://localhost/narzedzia_zapisz.php"
                let zapytanie3 = "a=UPDATE `narzedzia` SET `ID_plytki` = NULL WHERE `narzedzia`.`ID_plytki` = \(self.id_plytki);"
                zapisz_maszyna.zapisz(zapytanie3, url: path3)
                
                let storyBoard = UIStoryboard(name: "Main",bundle:  nil)
                let vc = storyBoard.instantiateViewControllerWithIdentifier("VC3")
                let path2 = "http://localhost/narzedzia_zapisz.php"
                let zapytanie2 = "a=DELETE FROM `plytki` WHERE `plytki`.`ID_plytki` = \(self.id_plytki);"
                zapisz_maszyna.zapisz(zapytanie2, url: path2)
                self.presentViewController(vc, animated: true, completion: nil)
            }
            ))
        
        alert.addAction(UIAlertAction(title: "anuluj",
            style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in return}
            ))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.maszyny.delegate = self
        var adres = "http://localhost/plytki_edytuj.php?id=\(id_plytki)"
        print(adres)
        maszyny.pobierzMaszyny(adres)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

