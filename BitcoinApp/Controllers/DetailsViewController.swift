//
//  DetailsViewController.swift
//  BitcoinApp
//
//  Created by Gorkopenko Sergey on 21.03.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    var data: BitcoinData!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idLabel.text = "\(data.tid)"
        dateLabel.text = data.date
        typeLabel.text = "\(data.type)"
        
    }
    
}
