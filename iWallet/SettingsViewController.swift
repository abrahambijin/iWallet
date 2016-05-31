//
//  SettingsViewController.swift
//  iWallet
//
//  Created by Bijin Abraham Idicula on 8/04/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var defaultAccount: UITextField!
    
    @IBOutlet weak var accountList: UIPickerView! = UIPickerView()
    
    @IBOutlet weak var budget: UITextField!
    
    var wallet: IWallet?
    var account: Account?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wallet = IWallet.sharedInstance
        
        accountList.hidden = true;
        defaultAccount.text = wallet?.defaultAccountName
        self.accountList.delegate = self
        self.accountList.dataSource = self
        self.defaultAccount.delegate = self
        budget.keyboardType = .DecimalPad
        budget.text = String(format:"%.2f", (wallet?.budget)!)
        account = DataAccess.getAccounts((wallet?.defaultAccountName)!)
    }
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return (DataAccess.getAccounts()!.count)
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DataAccess.getAccounts()![row].name!
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        defaultAccount.text = DataAccess.getAccounts()![row].name!
        account = DataAccess.getAccounts()![row]
        accountList.hidden = true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        accountList.hidden = false
        budget.resignFirstResponder()
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool)
    {

        NSUserDefaults.standardUserDefaults().setValue(account?.name, forKey: "defaultAccount")
        NSUserDefaults.standardUserDefaults().setDouble((account?.get_Balance())!, forKey: "defaultAccountBalance")
        NSUserDefaults.standardUserDefaults().setDouble(Double(budget.text!)!, forKey: "budget")

    }
    
    override func viewWillAppear(animated: Bool)
    {
        accountList.reloadAllComponents()
        
    }

}
