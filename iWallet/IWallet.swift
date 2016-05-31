//
//  IWallet.swift
//  Classes
//
//  Created by Palaniappan Subramaniam on 7/04/2016.
//  Copyright © 2016 Palaniappan Subramaniam. All rights reserved.
//

import UIKit
import CoreData

class IWallet
{
    
    var defaultAccountName: String
    {
        get
        {
            return NSUserDefaults.standardUserDefaults().stringForKey("defaultAccount")!
        }
    }
    
    var defaultAccountBalance: Double
    {
        get
        {
            return NSUserDefaults.standardUserDefaults().doubleForKey("defaultAccountBalance")
        }
    }
    
    var budget: Double
    {
        get
        {
            return NSUserDefaults.standardUserDefaults().doubleForKey("budget")
        }
    }
    
    var defaultCurrency: String
    {
        get
        {
                return DataAccess.getAccounts(defaultAccountName)!.currency!
        }
    }
    
    private init()
    {
        
        self.setDefaults()
        CurrencyList.sharedInstance
        
    }
    
    func getTotalBalance() -> Double
    {
        var total: Double = 0.0
        
        for account in DataAccess.getAccounts()!
        {
            var convertionRate = 1.0
            
            if account.currency != defaultCurrency
            {
                convertionRate = 2.0
            }
            total = total + (account.get_Balance() * convertionRate)
        }
        
        return total
    }
    
    
    /* Here we use a Struct to hold the instance of the model i.e itself
    */
    private struct Static
    {
        static var wallet: IWallet?
    }
    
    /* This is a class variable allowing me to access it
    without first instantiating the model
    
    Now we can retrieve the model without instantiating it directly
    
    var model = Model.sharedInstance
    */
    class var sharedInstance: IWallet
    {
        if !(Static.wallet != nil)
        {
            Static.wallet = IWallet()
        }
        return Static.wallet!
    }
    
    private func setDefaults()
    {
        if DataAccess.getAccounts()?.count == 0
        {
            DataAccess.saveAccount("Wallet", currency: "AUD", startBalance: 10000.00)
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if (!defaults.boolForKey("defaultAccount") && !defaults.boolForKey("defaultAccountBalance") && !defaults.boolForKey("budget"))
        {
            NSUserDefaults.standardUserDefaults().setValue(DataAccess.getAccounts(0)?.name, forKey: "defaultAccount")
            NSUserDefaults.standardUserDefaults().setDouble((DataAccess.getAccounts(0)?.get_Balance())!, forKey: "defaultAccountBalance")
            NSUserDefaults.standardUserDefaults().setDouble(100.00, forKey: "budget")
        }
        
    }
    
}

// HARD CODED DATA

//    func hardCode()
//    {
//        let acc1 = Account(name: "Wallet", startBalance: 10000.00, currency: "AUD")
//        let acc1t1 = Transaction(payee: "Alex" , date: "Jan 04, 2016", currency: "AUD", amount: 210.00, account: acc1)
//        let acc1t2 = Transaction(payee: "Ben" , date: "Jan 15, 2016", currency: "AUD", amount: 140.00, isExpense: false, account: acc1)
//        let acc1t3 = Transaction(payee: "Clara" , date: "Feb 21, 2016", currency: "INR", amount: 252.30, account: acc1)
//        acc1.transactions.append(acc1t1)
//        acc1.transactions.append(acc1t2)
//        acc1.transactions.append(acc1t3)
//        
//        
//        let acc2 = Account(name: "Bank", startBalance: 8500, currency: "INR")
//        let acc2t1 = Transaction(payee: "Denver" , date: "Feb 03, 2016", currency: "AUD", amount: 32.45, isExpense: true, account: acc2)
//        let acc2t2 = Transaction(payee: "Ethen" , date: "Feb 17, 2016", currency: "AUD", amount: 142.00, isExpense: false, account: acc2)
//        let acc2t3 = Transaction(payee: "Felix" , date: "Feb 22, 2016", currency: "INR", amount: 47.90, account: acc2)
//        acc2.transactions.append(acc2t1)
//        acc2.transactions.append(acc2t2)
//        acc2.transactions.append(acc2t3)
//        
//        let acc3 = Account(name: "Cash", startBalance: 4500, currency: "AUD")
//        let acc3t1 = Transaction(payee: "Genny" , date: "Jan 02, 2016", currency: "AUD", amount: 320.00, account: acc3)
//        let acc3t2 = Transaction(payee: "Hugh" , date: "Jan 18, 2016", currency: "AUD", amount: 121.10, isExpense: false, account: acc3)
//        let acc3t3 = Transaction(payee: "Iris" , date: "Feb 14, 2016", currency: "INR", amount: 49.99, account: acc3)
//        acc3.transactions.append(acc3t1)
//        acc3.transactions.append(acc3t2)
//        acc3.transactions.append(acc3t3)
//        
//        
//        let acc4 = Account(name: "Savings", startBalance: 8555, currency: "AUD")
//        let acc4t1 = Transaction(payee: "Jack" , date: "Mar 02, 2016", currency: "AUD", amount: 22.22, account: acc4)
//        let acc4t2 = Transaction(payee: "Kara" , date: "Mar 10, 2016", currency: "AUD", amount: 102.00, isExpense: false, account: acc4)
//        let acc4t3 = Transaction(payee: "Lara" , date: "Mar 20, 2016", currency: "INR", amount: 50.00, account: acc4)
//        acc4.transactions.append(acc4t1)
//        acc4.transactions.append(acc4t2)
//        acc4.transactions.append(acc4t3)
//        
//        
//        AccountList = []
//        
//        AccountList.append(acc1)
//        AccountList.append(acc2)
//        AccountList.append(acc3)
//        AccountList.append(acc4)
//        
//
//    }
//    
