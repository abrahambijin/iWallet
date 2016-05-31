//
//  AccountsTableViewCell.swift
//  iWallet
//
//  Created by Bijin Abraham Idicula on 7/04/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import UIKit

class AccountsTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var accountName: UILabel!
    

    @IBOutlet weak var balance: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
