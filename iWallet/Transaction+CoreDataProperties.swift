//
//  Transaction+CoreDataProperties.swift
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

extension Transaction {

    @NSManaged var amount: NSNumber?
    @NSManaged var convertionRate: NSNumber?
    @NSManaged var currency: String?
    @NSManaged var date: String?
    @NSManaged var isExpense: NSNumber?
    @NSManaged var location: String?
    @NSManaged var payee: String?
    @NSManaged var account: Account?
    
    
    //Converts the amount into account currency and returns based on expense or income
    
    func get_Amount()-> Double
    {
        let amount = self.amount
        var value = amount as! Double
        if getIsExpense()
        {
            value = value * -1
        }
        let convertion = convertionRate as! Double
        return (value * convertion)
    }
    
    // Converts NSNumber to boolean
    func getIsExpense() -> Bool
    {
        return isExpense != 0
    }
    
    
        // MARK: - API call
    
    private func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void)
    {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            if error != nil
            {
                callback("", error!.localizedDescription)
            }
            else {
                let result = NSString(data: data!, encoding:NSASCIIStringEncoding) as! String
                callback(result, nil)
            }
        }
        task.resume()
    }
    
    func setConvertionRate()
    {
        if(account?.currency == self.currency)
        {
            convertionRate = 1
            return
        }
        
        let BASE_URL:String = "http://free.currencyconverterapi.com/api/v3/convert?q="
        print(self.currency!)
        print(account?.currency)
        let FROM_TO = self.currency! + "_" + (account?.currency)!
        let getResult = BASE_URL + FROM_TO + "&compact=ultra"
        let url = NSURL(string: getResult)!
        let request = NSMutableURLRequest(URL: url)
        
        
        httpGet(request)
            {
                (data, error) -> Void in
                if error != nil
                {
                    print(error)
                }
                else
                {
                    do
                    {
                        let dat = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
                        let json = try NSJSONSerialization.JSONObjectWithData(dat, options: .AllowFragments)
                        if let item = json[FROM_TO]
                        {
                            dispatch_async(dispatch_get_main_queue())
                                {
                                    self.convertionRate = item as! Double
                            }
                        }
                        
                    }
                    catch
                    {
                        print("error serializing JSON: \(error)")
                    }
                }
        }
    }


}
