//
//  edytujNarzedzia.swift
//  aplikacja2
//
//  Created by m2dev on 20.08.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import UIKit

class edytujNarzedzia: UIViewController, maszynyDelegate {

    var id_narzedzia = String()
    
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
    }
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var opis: UITextField!
    
    @IBAction func aktualizuj(sender: AnyObject) {
        var zapisz_maszyna = zapisz()
        //let view = self.storyboard?.instantiateInitialViewController() as! ViewController2
        //self.navigationController?.pushViewController(view, animated: true)
        let storyBoard = UIStoryboard(name: "Main",bundle:  nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("VC3")
        let path = "http://localhost/narzedzia_zapisz.php"
        let zapytanie = "a=UPDATE `narzedzia` SET `nazwa` = '\(name.text!)', `opis` = '\(opis.text!)' WHERE `narzedzia`.`ID_narzedzia` = \(id_narzedzia);"
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
        let zapytanie = "a=UPDATE `maszyny_narzedzia` SET `ID_narzedzia` = NULL WHERE `maszyny_narzedzia`.`ID_narzedzia` = \(id_narzedzia);"
        zapisz_maszyna.zapisz(zapytanie, url: path)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func usun(sender: AnyObject) {
        let alert = UIAlertController(title: "Usuń", message: "Czy chcesz usunąć narzędzie?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: {(alert: UIAlertAction!) in
            
                var zapisz_maszyna = zapisz()
                //let view = self.storyboard?.instantiateInitialViewController() as! ViewController2
                //self.navigationController?.pushViewController(view, animated: true)
                let path = "http://localhost/narzedzia_zapisz.php"
                let zapytanie = "a=UPDATE `maszyny_narzedzia` SET `ID_narzedzia` = NULL WHERE `maszyny_narzedzia`.`ID_narzedzia` = \(self.id_narzedzia);"
                zapisz_maszyna.zapisz(zapytanie, url: path)
                
                var zapisz_maszyna2 = zapisz()
                //let view = self.storyboard?.instantiateInitialViewController() as! ViewController2
                //self.navigationController?.pushViewController(view, animated: true)
                let storyBoard = UIStoryboard(name: "Main",bundle:  nil)
                let vc = storyBoard.instantiateViewControllerWithIdentifier("VC3")
                let path2 = "http://localhost/narzedzia_zapisz.php"
                let zapytanie2 = "a=DELETE FROM `narzedzia` WHERE `narzedzia`.`ID_narzedzia` = \(self.id_narzedzia);"
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
        print("dupa")
        self.maszyny.delegate = self
        var adres = "http://localhost/narzedzia_edytuj.php?id=\(id_narzedzia)"
        print(adres)
        maszyny.pobierzMaszyny(adres)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
