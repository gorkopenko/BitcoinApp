//
//  BitcoinData.swift
//  BitcoinApp
//
//  Created by Gorkopenko Sergey on 21.03.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import Foundation

struct BitcoinData: Codable {
    let tid: Int
    let date: String
    let price: String
    let amount: String
    let type: String
    
    
    enum CodingKeys: CodingKey {
        
        case tid, date, price, amount, type
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tid = try container.decode(Int.self, forKey: .tid)
        self.price = try container.decode(String.self, forKey: .price)
        self.amount = try container.decode(String.self, forKey: .amount)
        let type = try container.decode(Int.self, forKey: .type)
        if type == 1 {
            self.type = "sell"
        } else {
            self.type = "buy"
        }
        
        let dateString = try container.decode(String.self, forKey: .date)
        guard let messageDate = TimeInterval(dateString) else {
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Cannot parsing")
        }
        let date = Date(timeIntervalSince1970: messageDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        self.date = dateFormatter.string(from: date)
        
    }
    
    
}

