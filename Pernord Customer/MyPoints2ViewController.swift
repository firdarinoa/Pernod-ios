//
//  MyPoints2ViewController.swift
//  Pernord Customer
//
//  Created by Firda Rinoa Sahidi on 3/28/17.
//  Copyright © 2017 Firda Rinoa Sahidi. All rights reserved.
//

import UIKit
import CoreData
class MyPoints2ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var outletselectBg: UIView!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var chooseOutlet: UIButton!
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

        
        
        chooseOutlet.layer.borderWidth = 1.0
        chooseOutlet.layer.cornerRadius = 8
        outletselectBg.isHidden = true
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        self.passTF.delegate = self;
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @IBAction func submitBtnAction(_ sender: UIButton) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseOutletAction(_ sender: UIButton) {
        outletselectBg.isHidden = false
    }
    @IBAction func outlet1Btn(_ sender: UIButton) {
        outletselectBg.isHidden = true
        chooseOutlet.setTitle( "     Outlet 1" , for: .normal )
    }

    @IBAction func outlet2Btn(_ sender: UIButton) {
        outletselectBg.isHidden = true
        chooseOutlet.setTitle( "     Outlet 2" , for: .normal )
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
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
