//
//  ViewController.swift
//  BitcoinApp
//
//  Created by Gorkopenko Sergey on 18.03.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITabBarDelegate {
    
    private var isFinishedTypingNumber: Bool = true
    
    var currencyData: CurrencyData?
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var sumTextField: UITextField!
    
    @IBOutlet weak var totalBitcoin: UILabel!
    
    @IBAction func pressButton(_ sender: UIButton) {
        if sumTextField.text == "" {
            let alert = UIAlertController(title: "Ошибка!", message: "Введите сумму", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        } else if let currencyData = currencyData {
            var rate = Double(currencyData.rate.replacingOccurrences(of: ",", with: ""))!
            var rate2 = Double(sumTextField.text!)!
            var total = rate2 / rate
            totalBitcoin.text = "\(total)"
            
        }
        
    }
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        
    }
}

extension ViewController: CoinManagerDelegate {
    
    func didUpdatePrice(currencyData: CurrencyData) {
        
        DispatchQueue.main.async {
            self.bitcoinLabel.text = currencyData.rate
            self.currencyLabel.text = currencyData.code
            self.currencyData = currencyData
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


