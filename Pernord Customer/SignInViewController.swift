//
//  SignInViewController.swift
//  Pernord Customer
//
//  Created by Firda Rinoa Sahidi on 3/2/17.
//  Copyright © 2017 Firda Rinoa Sahidi. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class SignInViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    @IBAction func loginBTN(_ sender: UIButton) {
        if(emailTF.text == ""){
            let alert = UIAlertController(title: nil,message: "Username/Email must be filled",preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true)
        }else if(passTF.text == ""){
            let alert = UIAlertController(title: nil,message: "Password must be filled",preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true)
        }else{
            login()
        }

    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //keyboard ilang ketika diklik apapun
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        //keyboard ilang ketika pencet enter
        self.emailTF.delegate = self;
        self.passTF.delegate = self;
        //naikin view ketika keyboard muncul
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ilangin keyboard ketika apapun dipencet
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //ilangin keyboard ketika pencet enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //naikin view ketika keyboard diketen
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
    
    var parameters: Parameters = [
        "username-or-email" : "aa",
        "password" : "aa"
    ]

    
    
    func login(){
        let loginURL = URL(string: SIGNIN_URL)!
        parameters["username-or-email"] = emailTF.text
        parameters["password"] = passTF.text
        Alamofire.request(SIGNIN_URL, method: .post, parameters: parameters).responseJSON { response in
            let result = response.result
            
            if result.isSuccess {
                print(result.value)
                let res = result.value as! [String: Any]
                if res["status"] as! Bool == false {
//                    let alert = UIAlertController(title: nil,message: nil,preferredStyle: UIAlertControllerStyle.alert)
//                    alert.message = (res["messages"] as! [String: Any])["username-or-email"] as! String?
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                    self.present(alert, animated: true)
                    let loginFailedViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginFailedViewController")
                    self.present(loginFailedViewController!, animated: true)
                } else {
                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let entity = NSEntityDescription.entity(forEntityName: "User", in: appDelegate.managedObjectContext!)
                    
                    let item = NSManagedObject(entity: entity!, insertInto: appDelegate.managedObjectContext)
                    
                    item.setValue(res["first_name"], forKey: "first_name")
                    item.setValue(res["last_name"], forKey: "last_name")
                    item.setValue(res["email"], forKey: "email")
                    
//                    do {
//                        try appDelegate.persistentStoreCoordinator?.destroyPersistentStore(at: appDelegate.applicationDocumentsDirectory.appendingPathComponent("DataModel.sqlite"), ofType: NSSQLiteStoreType, options: nil)
//                    } catch {
//                        NSLog("Error")
//                    }
                    
                    
                    do {
                        try appDelegate.managedObjectContext?.save()
                        self.present(nextViewController, animated:true, completion:nil)
                    } catch {
                        NSLog("Error")
                    }
 
                }

//                if let dict = result.value as? Dictionary<String, AnyObject>{
//                    
////                    if let message = dict["message"] as? Dictionary<String, AnyObject>{
////                        if let username = message["first_name"] as? String{
////                            self._username = username
////                            print(self._username)
////                        }
////                    }
//                }
            } else {
                if let dict = result.value as? Dictionary<String, AnyObject> {
                    let alert = UIAlertController()
                    alert.message = dict["messages"] as! String?
                    alert.show(self, sender: nil)
                }
            }
            
            
            print(response.request)
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            
        }
        
    }


}
