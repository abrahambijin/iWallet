//
//  TodayViewController.swift
//  iWalletToday
//
//  Created by Bijin Abraham Idicula on 22/05/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import UIKit

import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var defaultAccountBalance: UILabel!
    
    @IBOutlet weak var defaultAccount: UILabel!
    
    @IBOutlet weak var budgetBalance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.NewData)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaultAccount.text = defaults.valueForKey("defaultAccount") as? String
        defaultAccountBalance.text = String(defaults.doubleForKey("defaultAccountBalance"))
        budgetBalance.text = String(defaults.doubleForKey("budget"))
    }
    
}
