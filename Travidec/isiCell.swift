//
//  isiCell.swift
//  Travidec
//
//  Created by IOS on 12/12/21.
//

import UIKit

class isiCell: UITableViewCell {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var dateNTime: UILabel!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
