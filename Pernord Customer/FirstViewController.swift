//
//  FirstViewController.swift
//  Pernord Customer
//
//  Created by Firda Rinoa Sahidi on 12/29/16.
//  Copyright © 2016 Firda Rinoa Sahidi. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load user data from DB
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let allDataFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")

        // Do any additional setup after loading the view, typically from a nib.
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

    @IBAction func logoutBtnAction(_ sender: UIButton) {
        
        // Clear user data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let allDataFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            let results = try appDelegate.managedObjectContext?.fetch(allDataFetchRequest)
            
            let item: NSManagedObject = results![0]
            
            let first_name = item.value(forKey: "first_name") as! String
            let last_name = item.value(forKey: "last_name") as! String
            welcomeLabel.text = "Welcome, " + first_name + " " + last_name
            
            for item in results! {
                appDelegate.managedObjectContext?.delete(item);
            }
        } catch {
            NSLog("Error")
        }
    
        //move to another project
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

