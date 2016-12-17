//
//  LoginViewController.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 26/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import UIKit
/** View Controller including login view operations */
class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var twErrorMessage: UITextView!
    var authProvider: Controllers.Providers.AuthenticationProvider!
    let loginObserverName: String = "onLoginOperationDone"
    var tokenProvider: Controllers.Providers.TokenProvider!
    
    var validationUtil: Controllers.Utility.Validation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authProvider = Controllers.Providers.AuthenticationProvider()
        tokenProvider = Controllers.Providers.TokenProvider()
        validationUtil = Controllers.Utility.Validation()
        twErrorMessage.isHidden = true
        // Adding observer for login operation
        NotificationCenter.default.addObserver(self, selector: #selector(onLoginOperationDone), name: Notification.Name(loginObserverName), object: nil)
        
        // Checking authentication token exists
        if tokenProvider.getToken() != ""{
            goToPlaces()
        }
    }
    
    /** On login operation done this method will be notified */
    func onLoginOperationDone(notification: Notification){
        let userInfo = notification.userInfo
        if let data = userInfo?["data"]{
            let dataObject = try? JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
            let accessToken: String = dataObject?["accessToken"] as! String
            tokenProvider.setToken(token: accessToken)
            goToPlaces()
        }else if let error = userInfo?["error"]{
            let errorObject = try? JSONSerialization.jsonObject(with: error as! Data, options: .allowFragments) as! NSDictionary
            let errorMessage: String = errorObject?["message"] as! String
            DispatchQueue.main.async {
                self.twErrorMessage.isHidden = false
                self.twErrorMessage.text = errorMessage
            }
        }
    }
    
    /** Directs page to places page */
    func goToPlaces(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "segLoginToPlaces", sender: self)
        }
    }
    
    /** Performs login operations */
    @IBAction func performLogin(_ sender: Any) {
        if checkFields(){
            authProvider.performLogin(observer: loginObserverName, email: txtEmail.text!, password: txtPassword.text!)
        }
    }
    
    /** Client side validations */
    func checkFields() -> Bool{
        var errorMessage = ""
        if !validationUtil.isValidEmail(str: txtEmail.text!) || txtEmail.text?.characters.count == 0{
            errorMessage = "Please type a valid email address"
        }else if (txtPassword.text?.characters.count)! == 0{
            errorMessage = "Please type a valid password"
        }else if (txtEmail.text?.characters.count)! > 128{
            errorMessage = "Email address can contain max 128 characters"
        }else if (txtPassword.text?.characters.count)! > 32{
            errorMessage = "Passwords address can contain max 32 characters"
        }
        
        if errorMessage != ""{
            DispatchQueue.main.async {
                self.twErrorMessage.isHidden = false
                self.twErrorMessage.text = errorMessage
            }
            return false
        }
        return true
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
