//
//  RegisterViewController.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 26/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var twErrorMessage: UITextView!
    @IBOutlet weak var txtPasswordConfirmation: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    var validationUtil: Controllers.Utility.Validation!
    var authProvider: Controllers.Providers.AuthenticationProvider!
    var tokenProvider: Controllers.Providers.TokenProvider!
    let registerObserverName: String = "onRegisterOperationDone"
    override func viewDidLoad() {
        super.viewDidLoad()
        authProvider = Controllers.Providers.AuthenticationProvider()
        tokenProvider = Controllers.Providers.TokenProvider()
        validationUtil = Controllers.Utility.Validation()
        twErrorMessage.isHidden = true
        // Adding observer for register operation
        NotificationCenter.default.addObserver(self, selector: #selector(onRegisterOperationDone), name: Notification.Name(registerObserverName), object: nil)
        // Do any additional setup after loading the view.
    }
    
    /** On register operation done this method will be notified */
    func onRegisterOperationDone(notification: Notification){
        let userInfo = notification.userInfo
        if let data = userInfo?["data"]{
            let dataObject = try? JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
            let accessToken: String = dataObject?["accessToken"] as! String
            tokenProvider.setToken(token: accessToken)
            // Directing page to places page
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "segRegisterToPlaces", sender: self)
            }
        }else if let error = userInfo?["error"]{
            let errorObject = try? JSONSerialization.jsonObject(with: error as! Data, options: .allowFragments) as! NSDictionary
            let errorMessage: String = errorObject?["message"] as! String
            DispatchQueue.main.async {
                self.twErrorMessage.isHidden = false
                self.twErrorMessage.text = errorMessage
            }
        }
    }
    
    /** Client side validations */
    func checkFields() -> Bool{
        var errorMessage = ""
        if !validationUtil.isValidEmail(str: txtEmail.text!) || txtEmail.text?.characters.count == 0{
            errorMessage = "Please type a valid email address"
        }else if (txtPassword.text?.characters.count)! == 0{
            errorMessage = "Please type a valid password"
        }else if (txtPasswordConfirmation.text?.characters.count)! == 0{
            errorMessage = "Please type a valid password confirmation"
        }else if txtPasswordConfirmation.text != txtPassword.text{
            errorMessage = "Password and password confirmation must be same"
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
    
    
    /** Performs register operations */
    @IBAction func performRegister(_ sender: Any) {
        if checkFields(){
            authProvider.performRegister(observer: registerObserverName, email: txtEmail.text!, password: txtPassword.text!)
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
