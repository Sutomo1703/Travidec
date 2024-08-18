//
//  isiCell2.swift
//  Travidec
//
//  Created by Sutomo on 15/12/21.
//

import UIKit

class isiCell2: UITableViewCell {
    
    
    
    @IBOutlet weak var iduser: UILabel!
    @IBOutlet weak var pridash: UILabel!
    @IBOutlet weak var subdash: UILabel!
    @IBOutlet weak var namadash: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Do any additional setup after loading the view.
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
