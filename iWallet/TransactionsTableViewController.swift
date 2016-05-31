//
//  TransactionsTableViewController.swift
//  iWallet
//
//  Created by Bijin Abraham Idicula on 9/04/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import UIKit

class TransactionsTableViewController: UITableViewController {
    

    var transactions: [Transaction] = []
    var account: Account?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = account?.name
    }

    override func viewDidAppear(animated: Bool) {
        print("in did appear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transactions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "transactionCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? TransactionsTableViewCell

        let currentTransaction: Transaction = transactions[indexPath.row]
        
        cell?.payee?.text = currentTransaction.payee
        cell?.amount?.text = currentTransaction.currency! + " " + String(currentTransaction.amount!)
        
        return cell!
    }
    
    @IBAction func close(segue: UIStoryboardSegue)
    {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "transactionDetail"
        {
            if let index = tableView.indexPathForSelectedRow
            {
                let destinationNavigationController = segue.destinationViewController as! UINavigationController
                let destinationController = destinationNavigationController.viewControllers.first as? SingleTransactionTableViewController
                
                destinationController!.transaction = transactions[index.row]
               
            }
        }
        
        else if segue.identifier == "newTransactionFromTransactionsList"
        {
            let destinationNavigationController = segue.destinationViewController as! UINavigationController
            let destinationController = destinationNavigationController.viewControllers.first as? SingleTransactionTableViewController
            
            destinationController!.tAccount = account
            
        }
    }
    
    @IBAction func saveTransaction(segue: UIStoryboardSegue)
    {
        let source = segue.sourceViewController as? SingleTransactionTableViewController
        DataAccess.saveTransaction((source?.payee?.text)!, currency: (source?.currency.text)!, amount: (source?.getAmount())!, isExpense: (source?.getIsExpense())!, date: (source?.date.text)!, accountName: (source?.account.text)!, location: (source?.location.text)!, transaction: source?.transaction)
        let newAccount: Account = DataAccess.getAccounts((self.account?.name)!)!
        transactions = newAccount.getTransactionsAsArray()
        self.tableView.reloadData()
    }
    
    
    
    // MARK: - Enable Swipe to Delete
    // System method that enables swipe to delete on a row in a tableview controller.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    // System method that gets called when delete is selected
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let transaction = transactions[indexPath.row]
        DataAccess.deleteTransaction(transaction)
        transactions.removeAtIndex(indexPath.row)
        
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    }

}
