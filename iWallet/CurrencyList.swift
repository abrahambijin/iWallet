//
//  CurrencyList.swift
//  iWallet
//
//  Created by Bijin on 23/05/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import Foundation

//Static class to get the list of currencies from the API 

class CurrencyList
{
    var currencyList: Dictionary<String, String>
    
    private init()
    {
        currencyList = Dictionary()
        
        self.getCurrencyList()
    }
    
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
    
    
    private func getCurrencyList()
    {
        let getResult = "http://free.currencyconverterapi.com/api/v3/currencies"
        let url = NSURL(string: getResult)!
        let request = NSMutableURLRequest(URL: url)
        
        httpGet(request){
            (data, error) -> Void in
            if error != nil{
                print(error)
            }
            else
            {
                do
                {
                    let dat = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
                    let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(dat, options: .AllowFragments) as! NSDictionary
                    if let item = json["results"] as? NSDictionary
                    {
                        for(_, list) in item
                        {
                            let dict = list as! NSDictionary
                            dispatch_async(dispatch_get_main_queue())
                            {
                                let id = dict.valueForKey("id") as! String
                                let currencyName = dict.valueForKey("currencyName") as! String
                                self.currencyList[currencyName] = id
                            }
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
    
    func getCurrencyNames() -> [String]
    {
        return Array(currencyList.keys)
    }
    
    func getCurrency(name: String) -> String
    {
        return currencyList[name]!
    }
    
    func getKeyForValue(value: String) -> String?
    {
        for key in currencyList.keys
        {
            if currencyList[key] == value
            {
                return key
            }
        }
        return nil
    }
    
    /* Here we use a Struct to hold the instance of the model i.e itself
    */
    private struct Static
    {
        static var list: CurrencyList?
    }
    
    /* This is a class variable allowing me to access it
    without first instantiating the model
    
    Now we can retrieve the model without instantiating it directly
    
    var model = Model.sharedInstance
    */
    class var sharedInstance: CurrencyList
    {
        if !(Static.list != nil)
        {
            Static.list = CurrencyList()
        }
        return Static.list!
    }
    
}