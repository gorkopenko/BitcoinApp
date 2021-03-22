//
//  BitcoinManager.swift
//  BitcoinApp
//
//  Created by Gorkopenko Sergey on 18.03.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    
    func didUpdatePrice(currencyData: CurrencyData)
    func didFailWithError(error: Error)
    
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://api.coindesk.com/v1/bpi/currentprice"
    
    let currencyArray = ["USD", "EUR", "KZT"]
    
    func getCoinPrice(for currency: String) {
        
        let urlString = "\(baseURL)/\(currency).json"
        print(urlString)
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let bitcoinPrice = self.parseJSON(safeData) {
                        self.delegate?.didUpdatePrice(currencyData: bitcoinPrice)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CurrencyData? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Currency.self, from: data)
            
            return decodedData.data
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
