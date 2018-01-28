//
//  Constants.swift
//  Pernord Customer
//
//  Created by Firda Rinoa Sahidi on 4/17/17.
//  Copyright © 2017 Firda Rinoa Sahidi. All rights reserved.
//

import Foundation

let SIGNIN_URL = "http://192.168.1.100/api/mydrinks/index.php/api/customer/login"
let SIGNUP_URL = "http://192.168.1.100/api/mydrinks/index.php/api/customer/register"
let NOTIFICATION_URL = "http://192.168.1.100/api/mydrinks/index.php/api/message/getAll"
let TIPS_URL = "http://192.168.1.100/api/mydrinks/index.php/index.php/api/news/getAll"

//let SIGNIN_URL = "http://octolink.co.id/api/mydrinks/index.php/api/user/login"
typealias DownloadComplete = () -> ()
