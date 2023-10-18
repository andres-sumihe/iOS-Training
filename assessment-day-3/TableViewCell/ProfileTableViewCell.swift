//
//  ProfileTableViewCell.swift
//  training
//
//  Created by P090MMCTSE010 on 13/10/23.
//

import UIKit



struct Profile {
    let name: String
    let job: String
    let age: Int
    let bio: String
}

enum ProfileType: String {
    case name = "Nama"
    case job = "Pekerjaan"
    case age = "Umur"
    case bio = "Deskripsi Diri"
}


class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleComponent: UILabel!
    @IBOutlet weak var descriptionComponent: UILabel!
    @IBOutlet weak var ageComponent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValue(type: ProfileType, value: String) {
        
    
    }
    
}
