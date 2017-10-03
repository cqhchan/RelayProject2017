//
//  ViewController.swift
//  PaymentDemo
//
//  Created by Chan Qing Hong on 23/5/17.
//  Copyright © 2017 Chan Qing Hong. All rights reserved.
//



import UIKit
import PassKit

class ViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate, UITextFieldDelegate{
    
    var detail : String = "bizcanteenDrink"
    var identifier = ""
    var merchantcode = ""
    var merchantname = ""
    var AmountInString: String = ""
    @IBOutlet weak var MerchantName: UILabel!
  
    @IBOutlet weak var Amount: UITextField!
   

    //let iden = details.index((details?.startIndex)!, offsetBy: 5 )
   // identifier = details?.substring(to: (iden)!)
  //  print(identifier)
    //    if(identifier == "Relay"){
    
    
   // let endndex = details!.index((details?.startIndex)!, offsetBy: 8 )
   // let range = firstindex..<endindex
   // merchantcode = details?.substring(with: range)
   // print(merchantcode)
    
    
   // let nameindex = details?.index((details?.startIndex)!, offsetBy: 9 )

 //   merchantname = details?.substring(from: nameindex!)
 //   print (merchantname)
   //}
  
    
    
     

    let SupportedPaymentNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]
    
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        self.Amount.delegate = self
      
         MerchantName.text = detail
        print(detail)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func payWithApplePay(_ sender: AnyObject) {
      
        
        let formatter = NumberFormatter()
        
        formatter.generatesDecimalNumbers = true
        
      guard  let Final = formatter.number(from: Amount.text!) as? NSDecimalNumber
        else {return}
       AmountInString = formatter.string(from: Final)!
        print(Final)
        let supportedNetworks = [ PKPaymentNetwork.amex, PKPaymentNetwork.masterCard, PKPaymentNetwork.visa ]
        
        if PKPaymentAuthorizationViewController.canMakePayments() == false {
            let alert = UIAlertController(title: "Apple Pay is not available", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alert, animated: true, completion: nil)
        }
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: supportedNetworks) == false {
            let alert = UIAlertController(title: "No Apple Pay payment methods available", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alert, animated: true, completion: nil)
        }
        
        let request = PKPaymentRequest()
        request.currencyCode = "SGD"
        request.countryCode = "SG"
        request.merchantIdentifier = "merchant.com.relay.PaymentDemo"
        request.supportedNetworks = SupportedPaymentNetworks
        // DO NOT INCLUDE PKMerchantCapability.capabilityEMV
        request.merchantCapabilities = PKMerchantCapability.capability3DS
       
        request.paymentSummaryItems = [
            PKPaymentSummaryItem(label: detail, amount:  Final),PKPaymentSummaryItem(label: "Total", amount:  Final)
        ]
        
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        applePayController.delegate = self
        
        self.present(applePayController, animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: (@escaping (PKPaymentAuthorizationStatus) -> Void)) {
        print("paymentAuthorizationViewController delegates called")
        
        
        completion(PKPaymentAuthorizationStatus.success)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let popupvc = storyboard.instantiateViewController(withIdentifier: "popupview") as! popupViewController
         popupvc.detail = detail
        popupvc.totalamount = Amount.text!
        self.addChildViewController(popupvc)
    
        popupvc.view.frame = self.view.frame
        
        self.view.addSubview(popupvc.view)
       
        popupvc.didMove(toParentViewController: self)
        
        
        
    }
    
     /*   if payment.token.paymentData.count > 0 {
            let base64str = self.base64forData(payment.token.paymentData)
            let messsage = String(format: "Data Value: %@", base64str)
            let alert = UIAlertController(title: "Authorization Success", message: messsage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.performApplePayCompletion(controller, alert: alert)
        } else {
            let alert = UIAlertController(title: "Authorization Failed!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            return self.performApplePayCompletion(controller, alert: alert)
        }
    }*/
    
    func performApplePayCompletion(_ controller: PKPaymentAuthorizationViewController, alert: UIAlertController) {
        controller.dismiss(animated: true, completion: {() -> Void in
            self.present(alert, animated: false, completion: nil)
        })
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        print("paymentAuthorizationViewControllerDidFinish called")
    }
    
    func base64forData(_ theData: Data) -> String {
        let charSet = CharacterSet.urlQueryAllowed
        
        let paymentString = NSString(data: theData, encoding: String.Encoding.utf8.rawValue)!.addingPercentEncoding(withAllowedCharacters: charSet)
        
        return paymentString!
    }
    
}
        
        
        
        

    


