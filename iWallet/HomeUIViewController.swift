//
//  HomeUIViewController.swift
//  iWallet
//
//  Created by Bijin Abraham Idicula on 9/04/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import UIKit

class HomeUIViewController: UIViewController {

    var wallet: IWallet?
    var budget: String = ""
    
    @IBOutlet weak var defaultAccountName: UILabel!
    @IBOutlet weak var defaultAccountBalance: UILabel!
    
    @IBOutlet weak var totalBalance: UILabel!
    
    @IBOutlet weak var budgetLeft: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wallet = IWallet.sharedInstance

    }
    
    override func viewDidAppear(animated: Bool)
    {
        defaultAccountName.text = wallet!.defaultAccountName
        defaultAccountBalance.text = (wallet?.defaultCurrency)! + " " + String(format:"%.2f", wallet!.defaultAccountBalance)
        totalBalance.text = (wallet?.defaultCurrency)! + " " + String(format:"%.2f", wallet!.getTotalBalance())
        budget = String(format:"%.2f", (wallet?.budget)!)
        budgetLeft.text = "You can spend upto "+budget+" this week"
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func close(segue: UIStoryboardSegue)
    {
        
    }
    
    @IBAction func saveTransaction(segue: UIStoryboardSegue)
    {
        print("Save")
        let source = segue.sourceViewController as? SingleTransactionTableViewController
        DataAccess.saveTransaction((source?.payee?.text)!, currency: (source?.currency.text)!, amount: (source?.getAmount())!, isExpense: (source?.getIsExpense())!, date: (source?.date.text)!, accountName: (source?.account.text)!, location: "", transaction: source?.transaction)
        print("in save")
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "newTransactionHome"
        {
            let destinationNavigationController = segue.destinationViewController as! UINavigationController
            let destinationController = destinationNavigationController.viewControllers.first as? SingleTransactionTableViewController
            
            destinationController!.tAccount = DataAccess.getAccounts((wallet?.defaultAccountName)!)
        }
    }


}
