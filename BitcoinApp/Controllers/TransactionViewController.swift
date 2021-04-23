//
//  SecondViewController.swift
//  BitcoinApp
//
//  Created by Gorkopenko Sergey on 20.03.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fetchedBitcoin = [BitcoinData]()
    var myIndex = 0
    
    @IBOutlet weak var bitcoinTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseData()
        
        bitcoinTableView.dataSource = self
        bitcoinTableView.delegate = self
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedBitcoin.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bitcoinTableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "amount: \(fetchedBitcoin[indexPath.row].amount)"
        cell?.detailTextLabel?.text = "price: \(fetchedBitcoin[indexPath.row].price)$"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Details") as! TransactionDetailsViewController
        vc.data = fetchedBitcoin[indexPath.row]
        self.present(vc, animated: true)
        
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
            }
            guard let data = data else {
                return
            }
            do {
                
                let fetchedData = try JSONDecoder().decode([BitcoinData].self, from: data)
                self.fetchedBitcoin = fetchedData
                self.fetchedBitcoin = Array(self.fetchedBitcoin.prefix(500))
                
                self.bitcoinTableView.reloadData()
                
            }
            catch {
                print("Error2")
            }
        }
        
        task.resume()
        
    }

    

    
    
    
    
    
    
    
    

}
