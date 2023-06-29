//
//  StudyPalnsTableViewController.swift
//  PlanoDeEstudos
//
//  Created by Pedro Henrique on 28/06/23.
//

import UIKit

class StudyPalnsTableViewController: UITableViewController {
    
    let sm = StudyManager.shared
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yy HH:mm"
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onReceive(notification:)), name:  NSNotification.Name(rawValue: "Confirmed"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(cancelNotification(notification:)), name: NSNotification.Name(rawValue: "Cancel"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func cancelNotification(notification: Notification) {
        if let userInfo = notification.userInfo, let id = userInfo["id"] as? String {
            
            sm.removePlanNotification(id: id)
            tableView.reloadData()
        }
    }
    
    @objc func onReceive(notification: Notification) {
        if let userInfo = notification.userInfo, let id = userInfo["id"] as? String {
            sm.setPlanDone(id: id)
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sm.studyPlans.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let studyPlan = sm.studyPlans[indexPath.row]
        cell.textLabel?.text = studyPlan.section
        cell.detailTextLabel?.text = dateFormatter.string(from: studyPlan.date)
        
        cell.textLabel?.textColor = studyPlan.done ? .green: .systemPink
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sm.removePlan(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
}
