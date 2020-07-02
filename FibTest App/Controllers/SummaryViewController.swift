//
//  SummaryViewController.swift
//  FibTest App
//
//  Created by Francis Elias on 6/23/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    var fibValues : [FibObject]?

    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView()
    }
    
    func settingTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

// MARK: tableView dataSource and delegate functions

extension SummaryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fibValues?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as! MainTableViewCell
        cell.loadSummary(indexPath.row, fibValues![indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
