//
//  CurrencyListTableViewController.swift
//  iWallet
//
//  Created by Bijin Abraham Idicula on 20/05/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import UIKit

class CurrencyListTableViewController: UITableViewController {

    var currencyList: [String] = []
    var selectedCurrency: String = ""
    
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section:
        
        Int) -> Int {
            
            return currencyList.count
            
            
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath
        
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cellIdentifier = "currency"
            
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,
                
                forIndexPath: indexPath)
            
            
            cell.textLabel?.text = currencyList[indexPath.row]
            
            if(currencyList[indexPath.row] == selectedCurrency)
            {
                print (currencyList.count)
                print(currencyList[indexPath.row] + "=" + selectedCurrency)
                cell.accessoryType = .Checkmark
            }
            else
            {
                cell.accessoryType = .None
            }
            return cell
            
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let cell = tableView.cellForRowAtIndexPath(indexPath)
        {
            if cell.accessoryType == .Checkmark
            {
                cell.accessoryType = .None
            }
            else
            {
                cell.accessoryType = .Checkmark

            }
        }    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyList = CurrencyList.sharedInstance.getCurrencyNames()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
