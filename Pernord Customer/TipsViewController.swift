//
//  TipsViewController.swift
//  Pernord Customer
//
//  Created by Firda Rinoa Sahidi on 3/28/17.
//  Copyright © 2017 Firda Rinoa Sahidi. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
class TipsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var welcomeLabel: UILabel!
    var _username: String!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        getTips()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tipsCell", for: indexPath)
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var username: String{
        if _username == nil {
            _username = ""
        }
        return _username
    }

    
    func getTips(){
        //Alamofire Download
        let tipsURL = URL(string: TIPS_URL)!
        Alamofire.request(SIGNIN_URL, method: .get).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let username = dict["message"] as? String {
                    self._username = username
                    print(self._username)
                }
            }
            
            
        }
    }


}
