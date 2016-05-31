//
//  SingleTransactionTableViewController.swift
//  iWallet
//
//  Created by Bijin Abraham Idicula on 9/04/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import UIKit

class SingleTransactionTableViewController: UITableViewController {
    
    var transaction: Transaction?
    var tAccount: Account?

    
    @IBOutlet weak var payee: UITextField?
 
    @IBOutlet weak var isExpense: UISegmentedControl!
    
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var amount: UITextField?

    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var account: UILabel!
    
    @IBOutlet weak var accountcell: UITableViewCell!
   
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var locationCell: UITableViewCell!
    @IBOutlet var tabel: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if transaction != nil
        {
            payee?.text = transaction?.payee
            if transaction!.getIsExpense()
            {
                print(transaction!.getIsExpense())
                isExpense.selectedSegmentIndex = 0
            }
            else
            {
                print(transaction!.getIsExpense())
                isExpense.selectedSegmentIndex = 1
            }
            
            currency?.text = transaction?.currency
            print(transaction?.amount)
            
            amount?.text = String((transaction?.amount)!)
        
            date?.text = transaction?.date
        
            account?.text = transaction?.account!.name
        
            location?.text = transaction?.location
            
            self.title = "Edit Transaction"
        }
        else
        {
            self.title = "New Transaction"
            currency?.text = tAccount!.currency
            account?.text = tAccount?.name
            location?.text = ""
            
            let dateFomatter = NSDateFormatter()
            dateFomatter.dateStyle = NSDateFormatterStyle.MediumStyle
            date?.text = dateFomatter.stringFromDate(NSDate())
            
            
        }
        
        accountcell.accessoryType = .DisclosureIndicator
        locationCell.accessoryType = .DisclosureIndicator
        
        amount?.keyboardType = .DecimalPad
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func savefromAccountsList(segue: UIStoryboardSegue)
    {
        let sourceController = segue.sourceViewController as? AccountListTableViewController
        let indexPath = sourceController!.tableView.indexPathForSelectedRow
        account?.text = sourceController?.accountList[indexPath!.row].name
    }

    
    @IBAction func changeCurrency(segue: UIStoryboardSegue)
    {
        let sourceController = segue.sourceViewController as? CurrencyListTableViewController
        let indexPath = sourceController!.tableView.indexPathForSelectedRow
        currency?.text = CurrencyList.sharedInstance.getCurrency((sourceController?.currencyList[indexPath!.row])!)
    }

    @IBAction func saveLocation(segue: UIStoryboardSegue)
    {
        let sourceController = segue.sourceViewController as? ViewController
        location?.text = sourceController!.selectedPin?.name
    }


    @IBAction func dateEditing(sender: UITextField) {
        
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - 50, -10, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }

    
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        date.text = dateFormatter.stringFromDate(sender.date)

    }
    
    func doneButton(sender:UIButton)
    {
        date.resignFirstResponder() // To resign the inputView on clicking done.
    }


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "selectAccount"
        {
            let destinationNavigationController = segue.destinationViewController as? AccountListTableViewController
            destinationNavigationController?.selectedAccount = account.text!
        }
    
        else if segue.identifier == "selectCurrency"
        {
            let destinationNavigationController = segue.destinationViewController as? CurrencyListTableViewController
            destinationNavigationController?.selectedCurrency = CurrencyList.sharedInstance.getKeyForValue(currency.text!)!
    
        }
    }
    
    func getAmount() -> Double
    {
        return Double((amount?.text)!)!
    }
    
    func getIsExpense() -> Bool
    {
        return isExpense.selectedSegmentIndex == 0
    }

    @IBAction func closeToSingleTransaction(segue: UIStoryboardSegue)
    {
        
    }

}
