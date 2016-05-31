//
//  TransactionsTableViewCell.swift
//  iWallet
//
//  Created by Bijin Abraham Idicula on 9/04/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import UIKit

class TransactionsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var payee: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
