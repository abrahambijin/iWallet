//
//  iWalletTests.swift
//  iWalletTests
//
//  Created by Bijin Abraham Idicula on 22/05/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import XCTest
@testable import iWallet

class iWalletTests: XCTestCase {
    
    var testAccount1: Account?
    var testAccount2: Account?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        DataAccess.saveAccount("Test1", currency: "AUD", startBalance: 10000.00)
        DataAccess.saveAccount("Test2", currency: "INR", startBalance: 500.00)
        testAccount1 = DataAccess.getAccounts("Test1")!
        testAccount2 = DataAccess.getAccounts("Test2")!
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        DataAccess.deleteAccount(testAccount1)
        DataAccess.deleteAccount(testAccount2)
        super.tearDown()
    }
    
    func testNumberOfAccounts()
    {
        let initialCount = DataAccess.getAccounts()?.count
        
        DataAccess.saveAccount("Test3", currency: "INR", startBalance: 500.00)
        DataAccess.saveAccount("Test4", currency: "INR", startBalance: 500.00)
        
        let finalCount = DataAccess.getAccounts()?.count
        
        XCTAssertEqual(initialCount! + 2, finalCount, "Two account are added")
        
        DataAccess.deleteAccount(DataAccess.getAccounts("Test3"))
        DataAccess.deleteAccount(DataAccess.getAccounts("Test4"))
        
    }
    
    func testAddTransaction()
    {
        let initialCountForTestAccount1 = testAccount1?.transactions?.count
        let initialCountForTestAccount2 = testAccount2?.transactions?.count
        
        DataAccess.saveTransaction("T1", currency: "AUD", amount: 100, isExpense: true, date: "Mar 10, 2016", accountName: "Test1", location: "", transaction: nil)
        
        let finalCountForTestAccount1 = DataAccess.getAccounts("Test1")!.transactions?.count
        let finalCountForTestAccount2 = DataAccess.getAccounts("Test2")!.transactions?.count
        
        XCTAssertNotEqual(initialCountForTestAccount1, finalCountForTestAccount1, "Transaction added to Test Account 1")
        XCTAssertEqual(initialCountForTestAccount2, finalCountForTestAccount2, "Transaction not added to Test Account 2")
        
        let transactions = (DataAccess.getAccounts("Test1")?.getTransactionsAsArray())
        DataAccess.deleteTransaction(transactions![0])

    }
    
    func testAccountBalance()
    {
        let initialBalance = DataAccess.getAccounts("Test1")?.get_Balance()
        
        DataAccess.saveTransaction("T1", currency: "AUD", amount: 100, isExpense: true, date: "Mar 10, 2016", accountName: "Test1", location: "", transaction: nil)
        DataAccess.saveTransaction("T2", currency: "AUD", amount: 50, isExpense: false, date: "Mar 10, 2016", accountName: "Test1", location: "", transaction: nil)
        
        let finalBalance = DataAccess.getAccounts("Test1")?.get_Balance()
        
        XCTAssertEqual(initialBalance! - 50, finalBalance, "Balance is calculated correctly")
        
        let transactions = DataAccess.getAccounts("Test1")?.getTransactionsAsArray()
        DataAccess.deleteTransaction(transactions![0])
        DataAccess.deleteTransaction(transactions![1])
    }
    
    func testTransactionAmount()
    {
        DataAccess.saveTransaction("T1", currency: "AUD", amount: 100, isExpense: true, date: "Mar 10, 2016", accountName: "Test1", location: "", transaction: nil)
        DataAccess.saveTransaction("T2", currency: "AUD", amount: 50, isExpense: false, date: "Mar 10, 2016", accountName: "Test1", location: "", transaction: nil)
        
        let transactions = DataAccess.getAccounts("Test1")?.getTransactionsAsArray()
        XCTAssertLessThan(transactions![0].get_Amount(), 0, "Expense is negative")
        XCTAssertGreaterThan(transactions![1].get_Amount(), 0, "Income is positive")
        
        DataAccess.deleteTransaction(transactions![0])
        DataAccess.deleteTransaction(transactions![1])
        
    }
    
    func testTransactionType()
    {
        DataAccess.saveTransaction("T1", currency: "AUD", amount: 100, isExpense: true, date: "Mar 10, 2016", accountName: "Test1", location: "", transaction: nil)
        DataAccess.saveTransaction("T2", currency: "AUD", amount: 50, isExpense: false, date: "Mar 10, 2016", accountName: "Test1", location: "", transaction: nil)
        
        let transactions = DataAccess.getAccounts("Test1")?.getTransactionsAsArray()
        XCTAssertTrue(transactions![0].getIsExpense(), "T1 is an Expense")
        XCTAssertFalse(transactions![1].getIsExpense(), "T2 is an Income")

        
        DataAccess.deleteTransaction(transactions![0])
        DataAccess.deleteTransaction(transactions![1])
        
    }
    
}
