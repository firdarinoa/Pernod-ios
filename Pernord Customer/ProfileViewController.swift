//
//  ProfileViewController.swift
//  Pernord Customer
//
//  Created by Firda Rinoa Sahidi on 6/3/17.
//  Copyright © 2017 Firda Rinoa Sahidi. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var namaLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Load user data from DB
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let allDataFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            let results = try appDelegate.managedObjectContext?.fetch(allDataFetchRequest)
            
            let item: NSManagedObject = results![0]
            
            let first_name = item.value(forKey: "first_name") as! String
            let last_name = item.value(forKey: "last_name") as! String
            let email = item.value(forKey: "email") as! String
            
            welcomeLabel.text = "Welcome, " + first_name + " " + last_name
            namaLabel.text = first_name + " " + last_name
            emailLabel.text = email
        } catch {
            NSLog("Error")
        }
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
