//
//  EmployeeTableCell.swift
//  training
//
//  Created by P090MMCTSE010 on 19/10/23.
//

import UIKit

class EmployeeTableCell: UITableViewCell {

    @IBOutlet weak var nameComponent: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
