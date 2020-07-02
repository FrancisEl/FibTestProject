//
//  ViewController.swift
//  FibTest App
//
//  Created by Francis Elias on 6/23/20.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit
import BigInt

class MainViewController : UIViewController {

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var textField : UITextField!
    @IBOutlet weak var timeLabel : UILabel!
    var accessoryDoneButton: UIBarButtonItem!
    var accessoryToolBar : UIToolbar!
    var methodStart : Date?
    var methodFinish : Date?
    var fibValues : [FibObject]?

    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
        settingTableView()
        settingToolBar()
    }

    // MARK: navigationBar customization, changing color of bar and adding right bar button

    func settingNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemGreen
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        let rightBarButton = UIButton(type: .custom)
        rightBarButton.setTitle("Summary", for: .normal)
        rightBarButton.contentMode = .center
        rightBarButton.setTitleColor(.white, for: .normal)
        rightBarButton.addTarget(self, action: #selector(summaryAction(_:)), for: .touchUpInside)
        rightBarButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        rightBarButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        rightBarButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
    }

    // MARK: setting tableView dataSource and delegate to viewController, and set tablefooterview to an empty view to avoid any additional cells with seperators after our array has ended

    func settingTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    // MARK: initialization of a tooldbar and toolBarButton styled as Done.

    func settingToolBar() {
        accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        accessoryDoneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(donePressed))
        accessoryToolBar.items = [accessoryDoneButton]
        textField.inputAccessoryView = self.accessoryToolBar
    }

    // MARK: function fibonacci sequence returns [FibObject], the FibObject consists a value for our BigInt in addition to other variables related to Date in order to calculate the elapsed time. the input is of type BigInt instead of Int, in case the user entered in the text field more than max value of Int.

    func fibonaciSequence(_ number : BigInt) -> [FibObject]? {
        if number < 0 {
            return nil
        }
        var objects = [FibObject]()
        methodStart = Date()
        for n in 0...number {
            var fibObject = FibObject()
            if n == 0 {
                fibObject.startTime = Date()
                fibObject.number = 0
                fibObject.endTime = Date()
                fibObject.numberString = "\(fibObject.number!)"
            } else if n == 1 {
                fibObject.startTime = Date()
                fibObject.number = 1
                fibObject.endTime = Date()
                fibObject.numberString = "\(fibObject.number!)"
            } else {
                fibObject.startTime = Date()
                let total = objects[Int(n)-1].number! + objects[Int(n)-2].number!
                fibObject.number = total
                fibObject.endTime = Date()
                fibObject.numberString = "\(fibObject.number!)"
            }
            objects.append(fibObject)
        }
        methodFinish = Date()
        return objects
    }

    func alert (title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: tableView dataSource and delegate functions

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fibValues?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as! MainTableViewCell
        cell.loadMain(indexPath.row, fibValues![indexPath.row].numberString!)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController {
    
    // MARK: Action listener for the done button on keyboard

    @objc func donePressed() {
        view.endEditing(true)
        if let value = textField.text {
            if value != "" {
                guard let numberV = BigInt(value) else {
                    return
                }
                fibValues = fibonaciSequence(numberV)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                let executionTime = methodFinish!.timeIntervalSince(methodStart!)
                let msValue = Double(executionTime) * 1000
                timeLabel.text = "\(msValue)"
            } else {
                fibValues = nil
                timeLabel.text = ""
            }
            tableView.reloadData()
        }
    }
    
    // MARK: selector function for our navigation button, it restricts from proceeding in case the user haven't assigned a number

    @objc func summaryAction(_ sender : UIButton) {
        if fibValues == nil {
            alert(title: "Can't proceed", message: "Please chose a number in order to access this page")
        } else {
            weak var summaryViewController = storyboard?.instantiateViewController(withIdentifier: "SummaryViewController") as? SummaryViewController
            summaryViewController?.fibValues = fibValues
            navigationController?.pushViewController(summaryViewController!, animated: true)
        }
    }
}
