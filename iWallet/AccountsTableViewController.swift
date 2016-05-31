//
//  AccountsTableViewController.swift
//  iWallet
//
//  Created by Bijin Abraham Idicula on 7/04/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import UIKit

class AccountsTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var accountList: [Account] = []
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        
        return 1
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section:
        
        Int) -> Int
    {
            
            return accountList.count
            
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
            
        let cellIdentifier = "cell"
            
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,forIndexPath: indexPath) as? AccountsTableViewCell
            
            
        let currentAccount: Account = accountList[indexPath.row]
            
        cell?.accountName?.text = currentAccount.name! + ":"
        cell?.balance?.text = currentAccount.currency! + String(format: " %.2f",(currentAccount.get_Balance()))
            
            return cell!
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        accountList = DataAccess.getAccounts()!
        tableView.reloadData()
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
        let account = DataAccess.getAccounts(indexPath.row)!
        DataAccess.deleteAccount(account)
        accountList.removeAtIndex(indexPath.row)
        
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Navigation - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "transaction"
        {
            if let index = tableView.indexPathForSelectedRow
            {
                let destinationController = segue.destinationViewController as! TransactionsTableViewController
                destinationController.transactions = accountList[index.row].getTransactionsAsArray()
                destinationController.account = accountList[index.row]
            }
        }
    }

    
    
    //MARK - Adding Account Allert
    
    var accountName: UITextField?
    var defaultCurrency: UITextField?
    var startBalance: UITextField?
    
    weak var AddAlertSaveAction: UIAlertAction?
    
    @IBAction func addAccount(sender: UIBarButtonItem) {
        
        //set up the alertcontroller
        let title = NSLocalizedString("Add New Account", comment: "")
        let message = NSLocalizedString("Enter Details", comment: "")
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
        let saveButtonTitle = NSLocalizedString("Save", comment: "")
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        // Add the text field with handler
        alert.addTextFieldWithConfigurationHandler {(textField: UITextField!)in
            //listen for changes
            textField.placeholder = "Account Name:"

            NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleTextFieldTextDidChangeNotification:", name: UITextFieldTextDidChangeNotification, object: textField)	
            self.accountName = textField
        }
        
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Default Currency:"

            textField.delegate = self
            self.defaultCurrency = textField
            
        })
        
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Start Balance:"
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleTextFieldTextDidChangeNotification:", name: UITextFieldTextDidChangeNotification, object: textField)
            textField.keyboardType = .DecimalPad
            self.startBalance = textField
            
        })
        
        
        func removeTextFieldObserver() {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: self.accountName)
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: self.startBalance)
        }
        
        // Create the actions.
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .Cancel) { action in
            NSLog("Cancel Button Pressed")
            removeTextFieldObserver()
        }
        
        let saveAction = UIAlertAction(title: saveButtonTitle, style: .Default) { action in
            NSLog("Save Button Pressed")
            removeTextFieldObserver()
            
            DataAccess.saveAccount((self.accountName?.text)!, currency: (self.defaultCurrency?.text)!, startBalance: Double((self.startBalance?.text)!)!)
            self.accountList = DataAccess.getAccounts()!
            self.tableView.reloadData()
            
        }
        
        // disable the 'save' button (saveAction) initially
        saveAction.enabled = false
        
        // store the save action to toggle the enabled/disabled state when the text changed.
        AddAlertSaveAction = saveAction
        
        // Add the actions.
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        presentViewController(alert, animated: true, completion: nil)

        
    }
    
    //handler
    func handleTextFieldTextDidChangeNotification(notification: NSNotification) {
        let textField = notification.object as! UITextField
        
        // Enforce a minimum length of >= 1 for secure text alerts.
        AddAlertSaveAction!.enabled = !((textField.text?.isEmpty)!)
    }
    
    
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return (CurrencyList.sharedInstance.currencyList.count)
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CurrencyList.sharedInstance.getCurrencyNames()[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        defaultCurrency!.text = CurrencyList.sharedInstance.getCurrency(CurrencyList.sharedInstance.getCurrencyNames()[row])
    }

    
    func defaultCurrencySelector(sender: UITextField) {
        
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        let pickerView:UIPickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        inputView.addSubview(pickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - 50, -10, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView

    }
    
    func doneButton(sender:UIButton)
    {
        defaultCurrency!.resignFirstResponder() // To resign the inputView on clicking done.
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        defaultCurrencySelector(textField)
        return true
    }
    
}
