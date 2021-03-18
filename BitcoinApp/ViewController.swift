//
//  ViewController.swift
//  BitcoinApp
//
//  Created by Gorkopenko Sergey on 18.03.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var sumTextField: UITextField!
    @IBOutlet weak var totalBitcoin: UILabel!
    
    var coinManager = CoinManager()

         override func viewDidLoad() {
             super.viewDidLoad()
             
             coinManager.delegate = self
             pickerView.dataSource = self
             pickerView.delegate = self
         }
     }

     extension ViewController: CoinManagerDelegate {
         
         func didUpdatePrice(price: String, currency: String) {
             
             DispatchQueue.main.async {
                 self.bitcoinLabel.text = price
                 self.currencyLabel.text = currency
             }
         }
        
         
         func didFailWithError(error: Error) {
             print(error)
         }
     }

     extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
         
         func numberOfComponents(in pickerView: UIPickerView) -> Int {
               return 1
           }
           
           func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
               return coinManager.currencyArray.count
           }
           
           func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
               return coinManager.currencyArray[row]
           }
           
           func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
               let selectedCurrency = coinManager.currencyArray[row]
               coinManager.getCoinPrice(for: selectedCurrency)
           }
     }

