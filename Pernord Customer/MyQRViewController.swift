//
//  MyQRViewController.swift
//  Pernord Customer
//
//  Created by Firda Rinoa Sahidi on 6/3/17.
//  Copyright © 2017 Firda Rinoa Sahidi. All rights reserved.
//

import UIKit
import CoreData
class MyQRViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var qrCode: UIImageView!
    @IBOutlet weak var btnGenerate: UIButton!
    
    var qrcodeImage: CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showQR(_ sender: Any) {
        if qrcodeImage == nil {
            if welcomeLabel.text == "" {
                return
            }
            
            let data = welcomeLabel.text?.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrcodeImage = filter?.outputImage
            
            displayQRCodeImage()
            
            welcomeLabel.resignFirstResponder()
            
        }
            
            
        else {
            qrCode.image = nil
            qrcodeImage = nil
            btnGenerate.setTitle("Generate", for: UIControlState.normal)
        }

    }

    func displayQRCodeImage() {
        let scaleX = qrCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = qrCode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        qrCode.image = UIImage(ciImage: transformedImage)
        
        
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
