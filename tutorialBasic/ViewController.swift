//
//  ViewController.swift
//  tutorialBasic
//
//  Created by Jiraporn Praneet on 10/10/2561 BE.
//  Copyright © 2561 InformatixPlusCompanyLimited. All rights reserved.
//

import UIKit
import Alamofire
import EVReflection

class ViewController: UIViewController {

    var loginResource = LoginResource()
    var accessToken: String?
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        let url = "https://api.skylpr.com/index.php/api/v1/auth/verify/password"
        let parameters: [String: Any] = ["username": usernameTextField.text!, "password": passwordTextField.text!]
        //        let headers = ["Authorization": "Bearer " + accessToken!]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseObject { (response: DataResponse<LoginResource>) in
            switch response.result {
            case .success:
                let resource = response.value
                self.accessToken = resource?.accessToken
                self.loginResource.accessToken = resource?.accessToken
                self.performSegue(withIdentifier: "toMain", sender: nil)
                print("loginResource\(self.loginResource)")
            case .failure(let error):
                print("ERROR with '\(error)")
            }
        }
    }
}

