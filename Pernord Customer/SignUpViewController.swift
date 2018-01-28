//
//  SignUpViewController.swift
//  Pernord Customer
//
//  Created by Firda Rinoa Sahidi on 3/2/17.
//  Copyright © 2017 Firda Rinoa Sahidi. All rights reserved.
//

import UIKit
import Alamofire
class SignUpViewController: UIViewController,UITextFieldDelegate {
    var _username: String!
    var _message: String!

    @IBOutlet weak var fnameTF: UITextField!
    
    @IBOutlet weak var lnameTF: UITextField!
    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passTF: UITextField!
    
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var birthdateTF: UITextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
        if(fnameTF.text == ""){
            let alert = UIAlertController(title: nil,message: "First name must be filled",preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true)
        }else if(lnameTF.text == ""){
            let alert = UIAlertController(title: nil,message: "Last name must be filled",preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true)
        }else if(usernameTF.text == ""){
            let alert = UIAlertController(title: nil,message: "Username must be filled",preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true)
        }else if(emailTF.text == ""){
            let alert = UIAlertController(title: nil,message: "Email must be filled",preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true)
        }else if(passTF.text == ""){
            let alert = UIAlertController(title: nil,message: "Password must be filled",preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true)
        }else if(strlen(passTF.text)<6){
            let alert = UIAlertController(title: nil,message: "Password must be at least 6 characters",preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true)
        }else if(phoneTF.text == ""){
            let alert = UIAlertController(title: nil,message: "Phone must be filled",preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true)
        }else if(birthdateTF.text == ""){
            let alert = UIAlertController(title: nil,message: "Birth year must be filled",preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true)
        }else{
            register()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        self.emailTF.delegate = self;
        self.passTF.delegate = self;
        self.fnameTF.delegate = self;
        self.lnameTF.delegate = self;
        self.phoneTF.delegate = self;
        self.usernameTF.delegate = self;
        self.birthdateTF.delegate = self;
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    var parameters: Parameters = [
        "first_name" : "aa",
        "last_name" : "aaaaaaaaa",
        "customer_code" : "abbababa",
        "email" : "aa",
        "password" : "aa",
        "phone_number" : "aa",
        "birth_date" : "aa"
        
    ]
    
    func register(){
        let signupURL = URL(string: SIGNUP_URL)!
        parameters["first_name"] = fnameTF.text
        parameters["last_name"] = lnameTF.text
        parameters["customer_code"] = usernameTF.text
        parameters["email"] = emailTF.text
        parameters["password"] = passTF.text
        parameters["phone_number"] = phoneTF.text
        parameters["birth_date"] = birthdateTF.text
        
        Alamofire.request(SIGNUP_URL, method: .post, parameters: parameters).responseJSON { response in
            let result = response.result

            if result.isSuccess {
                print(result.value)
                let res = result.value as! [String: Any]
                if res["status"] as! Bool == false {
                        let alert = UIAlertController(title: nil,message: nil,preferredStyle: UIAlertControllerStyle.alert)
                        alert.message = (res["messages"] as! [String: Any])["email"] as! String?
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true)
                    
                } else {
                    
                    func backtoLogin(alert: UIAlertAction!) {
                        //move to another project
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
                        self.present(nextViewController, animated:true, completion:nil)
                    }
                    
                    let alert = UIAlertController(title: nil,message: "Sign Up Success",preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: backtoLogin))
                    self.present(alert, animated: true)

                }
                
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
