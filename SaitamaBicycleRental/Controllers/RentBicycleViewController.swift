//
//  RentBicycleViewController.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 27/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import UIKit

class RentBicycleViewController: UIViewController {
    var renter: Models.Renter!
    @IBOutlet weak var lblRenterName: UILabel!
    
    @IBOutlet weak var twMessage: UITextView!
    @IBOutlet weak var txtCardNumber: UITextField!
    
    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var txtExpiration: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
    
    var rentUtility: Controllers.Utility.RentBicycleUtility!
    var validationUtil: Controllers.Utility.Validation!
    var rentBicycleObserverName: String = "onRentBicycleOperationDone"
    override func viewDidLoad() {
        super.viewDidLoad()
        lblRenterName.text = renter.name
        rentUtility = Controllers.Utility.RentBicycleUtility()
        
        validationUtil = Controllers.Utility.Validation()
        self.twMessage.isHidden = true
        // Adding observer for rent bicycle operation
        NotificationCenter.default.addObserver(self, selector: #selector(onRentBicycleOperationDone), name: Notification.Name(rentBicycleObserverName), object: nil)
        // Do any additional setup after loading the view.
    }
    
    /** On rent bicycle operation done this method will be notified */
    func onRentBicycleOperationDone(notification: Notification){
        // todo: Message view should be designed as message box component
        let userInfo = notification.userInfo
        if let data = userInfo?["data"]{
            DispatchQueue.main.async {
                self.twMessage.isHidden = false
                self.twMessage.backgroundColor = UIColor(red: 56/255, green: 142/255, blue: 60/255, alpha: 1)
                self.twMessage.text = self.getMessage(data: data as! Data)
            }
        }else if let error = userInfo?["error"]{
            DispatchQueue.main.async {
                self.twMessage.isHidden = false
                self.twMessage.backgroundColor = UIColor(red: 216/255, green: 0, blue: 2/255, alpha: 0.73)
                self.twMessage.text = self.getMessage(data: error as! Data)
            }
        }
    }
    
    func getMessage(data: Data) -> String{
        let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
        return object!["message"] as! String
    }

    /** Performs renting a bicycle */
    @IBAction func rentBicycle(_ sender: Any) {
        if checkFields(){
            rentUtility.rent(observer: rentBicycleObserverName, cardNumber: txtCardNumber.text!, name: txtFullName.text!, expiration: txtExpiration.text!, code: txtCode.text!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** Client side validations */
    func checkFields() -> Bool{
        var errorMessage = ""
        if (txtCardNumber.text?.characters.count)! == 0 || (txtCardNumber.text?.characters.count)! > 16{
            errorMessage = "Please type a valid card number"
        }else if (txtFullName.text?.characters.count)! == 0{
            errorMessage = "Please type a valid name"
        }else if !validationUtil.isValidExpiration(str: txtExpiration.text!){
            errorMessage = "Expiration must be in format MM/YY"
        }else if (txtCode.text?.characters.count)! != 3{
            errorMessage = "Code must have 3 characters"
        }
        
        if errorMessage != ""{
            DispatchQueue.main.async {
                self.twMessage.isHidden = false
                self.twMessage.backgroundColor = UIColor(red: 216/255, green: 0, blue: 2/255, alpha: 0.73)
                self.twMessage.text = errorMessage
            }
            return false
        }
        return true
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
