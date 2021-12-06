//
//  SchoolTableViewCell.swift
//  20211205-DavidMathisen-NYCSchools
//
//  Created by user207826 on 12/5/21.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    
    var school : School? {
        didSet {
            //schoolIdLabel.text = school?.dbn
            schoolNameLabel.text = school?.schoolName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
