//
//  RunLogTableViewCell.swift
//  Pace
//
//  Created by Junior on 19/04/2019.
//  Copyright © 2019 capsella. All rights reserved.
//

import UIKit

class RunLogTableViewCell: UITableViewCell {

    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var avgPaceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configureCell(run: Run){
        self.durationLabel.text = run.duration.formatTimeToString()
        self.distanceLabel.text = "\(run.distance.metersToMiles(places: 2)) mi"
        self.avgPaceLabel.text = run.pace.formatTimeToString()
        self.dateLabel.text = run.date.getDateString()
    }
    
    
}
