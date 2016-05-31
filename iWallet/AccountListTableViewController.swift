//
//  AccountListTableViewController.swift
//  iWallet
//
//  Created by Bijin Abraham Idicula on 29/04/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import UIKit

class AccountListTableViewController: UITableViewController {
    
    var accountList: [Account] = []
    var selectedAccount: String = ""
    
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section:
        
        Int) -> Int {
            
            return accountList.count
            
            
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath
        
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cellIdentifier = "accountName"
            
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,
                
                forIndexPath: indexPath)
            
            cell.textLabel?.text = accountList[indexPath.row].name
            
            if(accountList[indexPath.row].name == selectedAccount)
            {
                cell.accessoryType = .Checkmark
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
        
        accountList = DataAccess.getAccounts()!

    }
    
    override func viewDidAppear(animated: Bool) {
        
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
