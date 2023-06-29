//
//  StudyPlanViewController.swift
//  PlanoDeEstudos
//
//  Created by Pedro Henrique on 28/06/23.
//

import UIKit
import UserNotifications

class StudyPlanViewController: UIViewController {

    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var sectionTextField: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    
    let sm = StudyManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dpDate.minimumDate = Date()
        
    }
    
    @IBAction func schedule(_ sender: Any) {
        let id = String(Date().timeIntervalSince1970)
        let studyPlan = StudyPlan(course: courseTextField.text!, section: sectionTextField.text!, date: dpDate.date, done: false, id: id)
        
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Matéria: \(studyPlan.course)"
        content.body = "Estudar \(studyPlan.section)"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("notification.wav"))
        content.categoryIdentifier = "Lembrete"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request,withCompletionHandler: nil)
        
        sm.addPlan(studyPlan)
        navigationController!.popViewController(animated: true)
    }
    


}
