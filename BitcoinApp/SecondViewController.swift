//
//  SecondViewController.swift
//  BitcoinApp
//
//  Created by Gorkopenko Sergey on 20.03.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource {
    
    var fetchedBitcoin = [BitcoinData]()
    var myIndex = 0
    
    @IBOutlet weak var bitcoinTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseData()
        
        bitcoinTableView.dataSource = self
        
            
    }
    
     
     override var prefersStatusBarHidden: Bool {
         return true
         
     }
     
     
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return fetchedBitcoin.count
     
     }
     
     public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = bitcoinTableView.dequeueReusableCell(withIdentifier: "cell")
         cell?.textLabel?.text = fetchedBitcoin[indexPath.row].amount
        cell?.detailTextLabel?.text = fetchedBitcoin[indexPath.row].price
        if cell?.detailTextLabel?.text == "0" {
            
            
        }
         cell?.textLabel?.text = fetchedBitcoin[indexPath.row].price
         
         return cell!
         
     }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "Segue", sender: self)
    }
    
    
    
    func parseData() {
        
        fetchedBitcoin = []
        
        let url = "https://www.bitstamp.net/api/transactions/"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if (error != nil) {
                print("Error")
            } else {
                do {
                    
                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
                    
                    for eachBitcoinData in fetchedData {
                        
                        let eachBitcoin = eachBitcoinData as! [String : Any]
                        
//                        let messageDate = eachBitcoin["date"] as? TimeInterval
//                        let date = Date(timeIntervalSince1970: messageDate?)
//                        let dateFormatter = DateFormatter()
//                        dateFormatter.dateFormat = "MMM d, h:mm a"
//                        let dateString = dateFormatter.string(from: date)
                        
                        let price = eachBitcoin["price"] as! String
                        let amount = eachBitcoin["amount"] as! String
                        
                        self.fetchedBitcoin.append(BitcoinData( price: price, amount: amount))
                        
                        
                    }
                       self.bitcoinTableView.reloadData()
                    
                    
                }
                catch {
                    print("Error2")
                }
            }
        }
            task.resume()
            
            
        }
        
    }

    
    
    
    
    
    
    
    

