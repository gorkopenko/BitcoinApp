//
//  BitcoinData.swift
//  BitcoinApp
//
//  Created by Gorkopenko Sergey on 21.03.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import Foundation

class BitcoinData: Codable {
//    var date: String
    var price: String
    var amount: String
    
    init( price: String, amount: String){
//        self.date = date
        self.price = price
        self.amount = amount
    }
    
    }

