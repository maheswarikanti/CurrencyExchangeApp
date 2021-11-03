//
//  ViewController.swift
//  CurrencyExchange
//
//  Created by Maheswari Kanti on 11/2/21.
//

import UIKit
import SwiftyJSON
import SwiftSpinner
import Alamofire

class ViewController: UIViewController {
    
    let baseURL = "https://free.currconv.com/api/v7/convert?q="
    let apiKey = "a414056cac6e2f94dca6"

    @IBOutlet weak var txtBaseCurrency: UITextField!
    
    @IBOutlet weak var txtCurrencySymbol: UITextField!
    
    @IBOutlet weak var lblCurrencyRate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getCurrencyConvertedRate(_ sender: Any) {
        
        if txtCurrencySymbol.text == "" {
            return
        }
        
        var curCon = self.txtBaseCurrency.text!.uppercased() + "_" + self.txtCurrencySymbol.text!.uppercased()
        
        var url = baseURL + curCon + "&compact=ultra&apiKey=" + apiKey
        
        SwiftSpinner.show("Get currency rates")
        
        AF.request(url).responseJSON { response in
            
            SwiftSpinner.hide()
            
            if response.error != nil {
                print(response.error!)
                return
            }
            
            let exchange = JSON(response.data!)
            
            if exchange.isEmpty == true {
                print("Currency codes are incorrect")
                return
            }
            
            var convertedValue = exchange[curCon]
            
            self.lblCurrencyRate.text = "Current Rate is: \(convertedValue)"
        }
    }
}

