//
//  BitcoinData.swift
//  BitcoinApp
//
//  Created by Gorkopenko Sergey on 18.03.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import Foundation

struct CurrencyData: Codable {
    let rate: String
    let code: String
}

struct Currency: Decodable {
    let data: CurrencyData
    
    enum CodingKeys: CodingKey {
        case bpi, KZT, USD, EUR
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .bpi)
        if let kzt = try? nestedContainer.decode(CurrencyData.self, forKey: .KZT) {
            self.data = kzt
        } else if let eur = try? nestedContainer.decode(CurrencyData.self, forKey: .EUR) {
            self.data = eur
        } else  if let usd = try? nestedContainer.decode(CurrencyData.self, forKey: .USD) {
            self.data = usd
        } else {
            throw DecodingError.dataCorruptedError(forKey: .bpi, in: container, debugDescription: "")
        }
    }
    
}
