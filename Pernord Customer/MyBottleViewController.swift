//
//  MyBottleViewController.swift
//  Pernord Customer
//
//  Created by Firda Rinoa Sahidi on 2/19/17.
//  Copyright © 2017 Firda Rinoa Sahidi. All rights reserved.
//

import UIKit
import CoreData

class MyBottleViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var sortBottleBtn: UIButton!
    @IBOutlet weak var selectBackground: UIView!

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortBottleBtn.layer.borderWidth = 1.0
        sortBottleBtn.layer.cornerRadius = 8
        selectBackground.isHidden = true
        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let allDataFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            let results = try appDelegate.managedObjectContext?.fetch(allDataFetchRequest)
            
            let item: NSManagedObject = results![0]
            
            let first_name = item.value(forKey: "first_name") as! String
            let last_name = item.value(forKey: "last_name") as! String
            
            welcomeLabel.text = "Welcome, " + first_name + " " + last_name
        } catch {
            NSLog("Error")
        }

    }

    @IBAction func sortBottleBtnAction(_ sender: UIButton) {
        selectBackground.isHidden = false
        
    }
    
    @IBAction func defaultBtn(_ sender: UIButton) {
        selectBackground.isHidden = true
        sortBottleBtn.setTitle( "     Default" , for: .normal )
        
    }
    
    @IBAction func outletBtn(_ sender: UIButton) {
        selectBackground.isHidden = true
        sortBottleBtn.setTitle( "     Outlet" , for: .normal )
        
    }
    
    @IBAction func brandBtn(_ sender: UIButton) {
        selectBackground.isHidden = true
        sortBottleBtn.setTitle( "     Brand" , for: .normal )
        
    }
    
    @IBAction func expBtn(_ sender: UIButton) {
        selectBackground.isHidden = true
        sortBottleBtn.setTitle( "     Expired Date" , for: .normal )
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
