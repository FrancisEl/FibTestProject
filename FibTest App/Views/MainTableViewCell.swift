//
//  MainTableViewCell.swift
//  FibTest App
//
//  Created by Francis Elias on 6/23/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var indexLabel : UILabel!
    @IBOutlet weak var valueLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        indexLabel.text = nil
    }

    // MARK: Same TableViewCell Class is used for both tableView's since they have similar UI, but different content

    func loadMain(_ index : Int, _ value : String) {
        indexLabel.text = "\(index)"
        valueLabel.text = value
    }

    func loadSummary(_ index : Int, _ value : FibObject) {
        let executionTime = value.endTime!.timeIntervalSince(value.startTime!)
        let msValue = Double(executionTime) * 1000
        indexLabel.text = "\(index)"
        valueLabel.text = "\(msValue)"
    }
}
