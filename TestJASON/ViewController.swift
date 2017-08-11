//
//  ViewController.swift
//  TestJSON
//
//  Created by BBC on 28/03/17.
//  Copyright © 2017 com.bbc.test. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    var ourData = [countryRatesStruct]()
    func testingFunctionAkshay() {
        print("test one")
        print("hi akshay")
        print ("hi nikhil from test one")
    }
    
    // MARK: Fethching and convertion of JSON data
    func downloadJsonData()
    {
        ourData = []
        
        
        // MARK: JSON Downloading content
        
        
        print("JSON started download")
        let url = URL(string: "http://api.fixer.io/latest")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if data == nil
            {
                print("ERROR")
            }
            else
            {
                
                do
                {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as AnyObject
                    print(jsonData)
                    if let countryRates = jsonData["rates"] as? [String: Double]
                    {
                        //print(countryRates["AUD"]!)
                        for (country,countryRates) in countryRates
                        {
                            let country = country
                            let rates = countryRates
                            self.ourData.append(countryRatesStruct(countryName: country, rates: rates))
                            
                            
                            
                            
                        }
                        self.tableView.reloadData()
                    }
                }
                catch
                {
                    print("ERROR catched")
                }
                
                
            }
        }
        task.resume()
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.dataSource = self
        downloadJsonData()
        
        
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: Table view and cell code
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ourData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = ourData[indexPath.row].countryName
        cell?.detailTextLabel?.text = "\(String(ourData[indexPath.row].rates)) $"
        return cell!
    }
}

struct countryRatesStruct {
    var countryName: String
    var rates: Double
    
    //        init(countryName: String, rates: Double) {
    //            self.countryName = countryName
    //            self.rates = rates
    //        }
}

