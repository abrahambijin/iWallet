//
//  Account+CoreDataProperties.swift
//  iWallet
//
//  Created by Bijin Abraham Idicula on 22/05/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Account {

    @NSManaged var currency: String?
    @NSManaged var name: String?
    @NSManaged var startBalance: NSNumber?
    @NSManaged var transactions: NSSet?
    
    func get_Balance() ->  Double
    {
        var balance = startBalance as! Double
        for t in getTransactionsAsArray()
        {
            balance = balance + t.get_Amount()
        }
        
        return balance
    }
    
    
    func getTransactionsAsArray() -> [Transaction]
    {
        return transactions?.allObjects as! [Transaction]
    }

}
