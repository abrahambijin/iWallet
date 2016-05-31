//
//  DataAccess.swift
//  iWallet
//
//  Created by Bijin on 22/05/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import UIKit
import CoreData

//Class to perform Core Data related Functions

class DataAccess
{
    static let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    static var managedContext: NSManagedObjectContext
    {
        get
        {
            return appDelegate.managedObjectContext
        }
    }
    
    class func saveAccount(name: String, currency: String, startBalance: Double)
    {
        
        let entity =  NSEntityDescription.entityForName("Account",inManagedObjectContext:managedContext)
        let account = Account(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        account.setValue(name, forKey: "name")
        account.setValue(currency, forKey: "currency")
        account.setValue(startBalance, forKey: "startBalance")
        
        appDelegate.saveContext()
    }
    
    class func getAccounts() -> [Account]?
    {
        
        var accounts: [Account]?
        do
        {
            let fetchRequest = NSFetchRequest(entityName:"Account")
            let results = try managedContext.executeFetchRequest(fetchRequest)
            
            accounts = results as? [Account]
        }
        catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return accounts
    }
    
    class func getAccounts(index: Int) -> Account?
    {
        let acc = getAccounts()![index]
        return acc
    }
    
    class func getAccounts(accountName: String) -> Account?
    {
        
        var accounts: [Account]?
        do
        {
            let fetchRequest = NSFetchRequest(entityName:"Account")
            fetchRequest.predicate = NSPredicate(format: "name = %@", accountName)
            let result = try managedContext.executeFetchRequest(fetchRequest)
            
            accounts = result as? [Account]
        }
        catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        if accounts!.isEmpty
        {
            return nil
        }
        
        return accounts![0] as Account
    }
    
    
    class func saveTransaction(payee: String, currency: String, amount: Double, isExpense: Bool, date: String, accountName: String, location: String, transaction: Transaction?)
    {
        
        let entity =  NSEntityDescription.entityForName("Transaction", inManagedObjectContext:managedContext)
        
        
        // Update the existing object with the data passed in from the View Controller
        if let _ = transaction
        {
            transaction!.payee = payee
            transaction!.currency = currency
            transaction!.amount = amount
            let account = getAccounts(accountName)
            if let _ = account
            {
                transaction!.account = account
            }
            transaction!.setConvertionRate()
            transaction!.isExpense = isExpense
            transaction!.date = date
            transaction!.location = location
        }
            
            // Create a new movie object and update it with the data passed in from the View Controller
        else
        {
            // Create an object based on the Entity
            let newTransaction = Transaction(entity: entity!, insertIntoManagedObjectContext:managedContext)
            newTransaction.payee = payee
            newTransaction.currency = currency
            newTransaction.amount = amount
            let account = getAccounts(accountName)
            if let _ = account
            {
                newTransaction.account = account
            }
            newTransaction.setConvertionRate()
            newTransaction.isExpense = isExpense
            newTransaction.date = date
            
            newTransaction.location = location
        }
        
        appDelegate.saveContext()
    }
    
    class func deleteAccount(account: Account?)
    {
        managedContext.deleteObject(account!)
        appDelegate.saveContext()
    }
    
    class func deleteTransaction(tranaction: Transaction?)
    {
        managedContext.deleteObject(tranaction!)
        appDelegate.saveContext()
    }

}
