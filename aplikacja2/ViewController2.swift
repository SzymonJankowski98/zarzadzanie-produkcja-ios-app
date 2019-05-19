//
//  ViewController2.swift
//  aplikacja2
//
//  Created by m2dev on 16.07.2018.
//  Copyright © 2018 szymon. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate, maszynyDelegate {

    var array = [String]()
    var id = [String]()
    var opis = [String]()
    var id_m = String()
    var nazwa_m = String()
    var id_m_edytuj = String()
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func ref(sender: AnyObject) {
        tableView.reloadData()
    }
    
    func setTableWiev(dane: JSON) {
        opis.removeAll()
        array.removeAll()
        if dane.count == 0
        {
            return
        }
        for i in 0...dane.count-1 {
            array.append(dane[i]["nazwa"].string!)
            if dane[i]["ID_maszyny"].string != nil
            {
                id.append(dane[i]["ID_maszyny"].string!)
            }
            else
            {
                id.append("0")
            }
            if dane[i]["opis"].string != nil
            {
                opis.append(dane[i]["opis"].string!)
            }
            else
            {
                opis.append(" ")
            }
        }
        if maszyny.a == false
        {
            tableView.reloadData()
            maszyny.a = true
        }
    }
    var maszyny = MaszynyDB()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.maszyny.delegate = self
        maszyny.pobierzMaszyny()
        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! cellMaszyny
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)

        }
        cell.nazwa?.text = array[indexPath.row]
        cell.opis?.text = "Opis: \(opis[indexPath.row])"
        return cell
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .Normal, title: " edytuj ") { action, index in
            self.id_m_edytuj = self.id[indexPath.row]
            self.performSegueWithIdentifier("edytujMaszyne", sender: self)
        }
        edit.backgroundColor = UIColor(red: 226/255, green: 225/255, blue: 1/255, alpha: 1.0)
        return [edit]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        id_m = id[indexPath.row]
        nazwa_m = array[indexPath.row]
        self.performSegueWithIdentifier("SendDataSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SendDataSegue"
        {
            if let View = segue.destinationViewController as? ViewController3
            {
                //View.id_maszyny = id_m
                id_maszyny = id_m
                nazwa_maszyny_label = nazwa_m
            }
        }
        if segue.identifier == "edytujMaszyne"
        {
            if let View = segue.destinationViewController as? edytujMaszyne
            {
                View.id_maszyny = id_m_edytuj
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
